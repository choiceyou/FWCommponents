//
//  FWBaseViewController.swift
//  FWCommponents
//
//  Created by xfg on 2018/4/13.
//  Copyright © 2018年 xfg. All rights reserved.
//

import Foundation
import UIKit

class FWBaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.navigationController != nil && self.navigationController?.isNavigationBarHidden == false && self.navigationController?.childViewControllers[0] != self {
            
            self.view.frame.size.height = UIScreen.main.bounds.height - kStatusAndNavBarHeight
            
        }
    }
}
