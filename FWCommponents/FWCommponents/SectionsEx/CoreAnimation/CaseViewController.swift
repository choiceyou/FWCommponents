//
//  CaseViewController.swift
//  FWCommponents
//
//  Created by xfg on 2018/4/17.
//  Copyright © 2018年 xfg. All rights reserved.
//

import Foundation
import UIKit

class CaseViewController: AnimationBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "动画案例"
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.itemTitleArray = ["Path", "钉钉", "点赞"]
        self.setupItemBtn()
        
        self.animateViewWidth = 50
        self.view.addSubview(self.animateView)
    }
    
    override func btnAction(btn: UIButton) {
        switch btn.tag {
        case 0:
            self.pathAnimation()
            break
        case 1:
            self.ddAnimation()
            break
        case 2:
            self.likeAnimation()
            break
        default:
            break
        }
    }
}

extension CaseViewController {
    
    /// 仿path动画
    func pathAnimation() {
        
    }
    
    /// 仿钉钉动画
    func ddAnimation() {
        
    }
    
    /// 点赞动画
    func likeAnimation() {
        
    }
}
