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
        tableView.register(SeeItemTableViewCell.self, forCellReuseIdentifier: "cellId")
        return tableView
    }()
    
    func fw_setupViewModel(viewModel: FWViewModelProtocol) {
        
        self.seeViewModel = viewModel as! SeeViewModel
    }
    
    override func fw_setupViews() {
        self.addSubview(self.tableView)
        FWMJRefreshManager.refresh(refreshedView: self.tableView, target: self, headerRereshAction: #selector(headerRefreshAction), shouldHeaderBeginRefresh: false, footerRereshAction: nil)
        
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
    
        // 模拟网络请求结束
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            FWMJRefreshManager.endRefresh(refreshedView: self.tableView)
        }
    }
}


// MARK: - UITableViewDataSource
extension SeeMainView {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! SeeItemTableViewCell
        cell.textLabel?.text = "测试测试"
        return cell
    }
}
