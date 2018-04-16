//
//  CommonAnimationViewController.swift
//  FWCommponents
//
//  Created by xfg on 2018/4/13.
//  Copyright © 2018年 xfg. All rights reserved.
//

import Foundation
import UIKit

class CommonAnimationViewController: AnimationBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "基础动画"
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.itemTitleArray = ["位移", "透明度", "缩放", "旋转", "背景色"]
        self.setupItemBtn()
    }
    
    override func btnAction(btn: UIButton) {
        switch btn.tag {
        case 0:
            
            break
        default:
            break
        }
    }
}
