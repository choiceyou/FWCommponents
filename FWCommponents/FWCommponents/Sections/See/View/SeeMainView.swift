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
    
    func fw_setupViewModel(viewModel: AnyObject) {
        
        self.seeViewModel = viewModel as! SeeViewModel
    }
    
    override func fw_setupViews() {
        self.addSubview(self.tableView)
        self.setNeedsUpdateConstraints()
        self.updateConstraintsIfNeeded()
    }
    
    override func fw_bindViewModel() {
        
    }
}

extension SeeMainView {
    
    override func updateConstraints() {

        self.tableView.snp.makeConstraints { [weak self] (make) in
            make.edges.equalTo(self!)
        }
        super.updateConstraints()
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
