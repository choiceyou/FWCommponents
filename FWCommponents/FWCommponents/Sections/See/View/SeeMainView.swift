//
//  SeeMainView.swift
//  FWCommponents
//
//  Created by xfg on 2018/4/24.
//  Copyright © 2018年 xfg. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class SeeMainView: FWBaseView, UITableViewDelegate, UITableViewDataSource {
    
    var seeViewModel: SeeViewModel!
    
    lazy var tableView: UITableView = {
        
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(SeeStatusTableViewCell.self, forCellReuseIdentifier: "cellId")
        return tableView
    }()
    
    func fw_setupViewModel(viewModel: FWViewModelProtocol) {
        
        self.seeViewModel = viewModel as! SeeViewModel
    }
    
    override func fw_setupViews() {
        self.addSubview(self.tableView)
        FWMJRefreshManager.refresh(refreshedView: self.tableView, target: self, headerRereshAction: #selector(headerRefreshAction), footerRereshAction: nil)
        
        self.setNeedsUpdateConstraints()
        self.updateConstraintsIfNeeded()
    }
    
    override func fw_bindViewModel() {
        
        
    }
}

extension SeeMainView {
    
    override func updateConstraints() {

        self.tableView.snp.makeConstraints { [weak self] (make) in
            guard let strongSelf = self else {
                return
            }
            make.edges.equalTo(strongSelf)
        }
        super.updateConstraints()
    }
    
    @objc func headerRefreshAction() {
        
        self.seeViewModel.requestData(successBlock: { [weak self] in
            
            guard let stongSelf = self else {
                return
            }
            stongSelf.tableView.reloadData()
            FWMJRefreshManager.endRefresh(refreshedView: stongSelf.tableView)
            
        }) {
            print("加载数据失败")
        }
    }
}


// MARK: - UITableViewDataSource
extension SeeMainView {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.seeViewModel.responseLayouts.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.seeViewModel.responseLayouts[indexPath.row].height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! SeeStatusTableViewCell
        cell.selectionStyle = .none
        cell.setupLayout(layout: self.seeViewModel.responseLayouts[indexPath.row])
        return cell
    }
}
