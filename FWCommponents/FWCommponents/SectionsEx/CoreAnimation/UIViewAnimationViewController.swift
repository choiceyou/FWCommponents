//
//  UIViewAnimationViewController.swift
//  FWCommponents
//
//  Created by xfg on 2018/4/16.
//  Copyright © 2018年 xfg. All rights reserved.
//

import Foundation
import UIKit

class UIViewAnimationViewController: AnimationBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "仿射动画"
        
        self.itemTitleArray = ["位移", "缩放", "旋转", "组合", "反转"]
        self.setupItemBtn()
        
        self.animateViewWidth = 50
        self.view.addSubview(self.animateView)
    }
    
    override func btnAction(btn: UIButton) {
        switch btn.tag {
        case 0:
            self.positionAnimation()
            break
        case 1:
            self.scaleAnimation()
            break
        case 2:
            self.rotationAnimation()
            break
        case 3:
            self.combinationAnimation()
            break
        case 4:
            self.invertAnimation()
            break
        default:
            break
        }
    }
}


extension UIViewAnimationViewController {
    
    /// 位移
    func positionAnimation() {
        self.animateView.transform = CGAffineTransform.identity
        UIView.animate(withDuration: 1.0) {
            self.animateView.transform = CGAffineTransform(translationX: 100, y: 100)
        }
    }
    
    /// 缩放
    func scaleAnimation() {
        self.animateView.transform = CGAffineTransform.identity
        UIView.animate(withDuration: 1.0) {
            self.animateView.transform = CGAffineTransform(scaleX: 2, y: 2)
        }
    }
    
    /// 旋转
    func rotationAnimation() {
        self.animateView.transform = CGAffineTransform.identity
        UIView.animate(withDuration: 1.0) {
            self.animateView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        }
    }
    
    /// 组合
    func combinationAnimation() {
        self.animateView.transform = CGAffineTransform.identity
        UIView.animate(withDuration: 1.0) {
            let transform1 = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
            let transform2 = CGAffineTransform(scaleX: 0.5, y: 0.5).concatenating(transform1)
            self.animateView.transform = CGAffineTransform(translationX: 100, y: 100).concatenating(transform2)
        }
    }
    
    /// 反转
    func invertAnimation() {
        self.animateView.transform = CGAffineTransform.identity
        UIView.animate(withDuration: 1.0) {
            self.animateView.transform = CGAffineTransform(scaleX: 2, y: 2).inverted()
        }
    }
}
