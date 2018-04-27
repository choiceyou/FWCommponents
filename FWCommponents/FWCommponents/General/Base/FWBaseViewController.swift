//
//  FWBaseViewController.swift
//  FWCommponents
//
//  Created by xfg on 2018/4/13.
//  Copyright © 2018年 xfg. All rights reserved.
//

import Foundation
import UIKit
import FWSideMenu

class FWBaseViewController: UIViewController, FWViewControllerProtocol {
    
    public var isNeedBlueNav: Bool = false
    public var sideMenuPanMode: FWSideMenuPanMode = .none
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 11.0, *) {
            
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        self.setCurrentViewFrame()
        
        self.fw_setupViews()
        self.fw_bindViewModel()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        self.setCurrentViewFrame()
    }
    
    func fw_setupViews() {
        
    }
    
    func fw_bindViewModel() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if self.isNeedBlueNav {
            // 设置导航栏
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont.systemFont(ofSize: navTitleFont)]
            self.navigationController?.navigationBar.setBackgroundImage(FWUtilsManager.resizableImage(imageName: "header_bg_message", edgeInsets: UIEdgeInsetsMake(0, 0, 0, 0)), for: .default)
            
            // 设置状态栏
            UIApplication.shared.statusBarStyle = .lightContent
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 本页面开启支持打开侧滑菜单
        self.menuContainerViewController.sideMenuPanMode = sideMenuPanMode
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.isNeedBlueNav {
            // 设置导航栏
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black, NSAttributedStringKey.font: UIFont.systemFont(ofSize: navTitleFont)]
            self.navigationController?.navigationBar.setBackgroundImage(FWUtilsManager.getImageWithColor(color: UIColor.white), for: .default)
        }
        
        // 离开本页面时关闭支持打开侧滑菜单
        self.menuContainerViewController.sideMenuPanMode = .none
    }
    
    func setCurrentViewFrame() {
        
        if self.navigationController != nil && self.navigationController?.isNavigationBarHidden == false && self.navigationController?.childViewControllers[0] != self {
            
            self.view.frame.size.height = UIScreen.main.bounds.height - kStatusAndNavBarHeight
        }
        else if self.navigationController != nil && self.navigationController?.isNavigationBarHidden == false && self.navigationController?.childViewControllers[0] == self {
            
            // self.view.frame.size.height = UIScreen.main.bounds.height - kStatusAndNavBarHeight - kTabBarHeight
        }
    }
}
