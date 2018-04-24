//
//  SeeViewController.swift
//  FWSideMenu
//
//  Created by xfg on 2018/4/10.
//  Copyright © 2018年 xfg. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa

class SeeViewController: FWBaseViewController {
    
    lazy var seeViewModel: SeeViewModel = {
       
        let seeViewModel = SeeViewModel()
        return seeViewModel
    }()
    
    lazy var seeMainView: SeeMainView = {
       
        let seeMainView = SeeMainView()
        seeMainView.fw_setupViewModel(viewModel: self.seeViewModel)
        return seeMainView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "看点"
        
        if #available(iOS 11.0, *) {
            seeMainView.tableView.contentInsetAdjustmentBehavior = .never
        }
        
        self.sideMenuPanMode = .defaults
        self.isNeedBlueNav = true
    }
    
    override func fw_setupViews() {
        
        self.view.addSubview(self.seeMainView)
    }
    
    override func updateViewConstraints() {
        
        self.seeMainView.snp.makeConstraints { [weak self] (make) in
            make.edges.equalTo(self!.view)
        }
        
        super.updateViewConstraints()
    }
}
