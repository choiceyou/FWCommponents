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
        
        self.itemTitleArray = ["位移", "透明度", "缩放", "旋转", "背景色"]
        self.setupItemBtn()
        
        self.view.addSubview(self.animateView)
    }
    
    override func btnAction(btn: UIButton) {
        switch btn.tag {
        case 0:
            self.positionAnimation()
            break
        case 1:
            self.opacityAniamtion()
            break
        case 2:
            self.scaleAniamtion()
            break
        case 3:
            self.transAniamtion()
            break
        case 4:
            self.backgroundAniamtion()
            break
        default:
            break
        }
    }
}

extension CommonAnimationViewController {
    
    /**
     可选的KeyPath
     transform.scale 比例转换
     transform.scale.x
     transform.scale.y
     transform.rotation 旋转
     transform.rotation.x
     transform.rotation.y
     transform.rotation.z
     transform.translation
     transform.translation.x
     transform.translation.y
     transform.translation.z
     
     opacity = 透明度
     margin
     zPosition
     backgroundColor 背景颜色
     cornerRadius 圆角
     borderWidth
     bounds
     contents
     contentsRect
     cornerRadius
     frame
     hidden
     mask
     masksToBounds
     opacity
     position
     shadowColor
     shadowOffset
     shadowOpacity
     shadowRadius
     
     */
    
    /// 位移
    func positionAnimation() {
        
        /// 方法一
        let baseAnimation = CABasicAnimation(keyPath: "position")
        baseAnimation.fromValue = NSValue(cgPoint: CGPoint(x: 0, y: (self.view.frame.height - 50)/2 - 50))
        baseAnimation.toValue = NSValue(cgPoint: CGPoint(x: kScreenW, y: (self.view.frame.height - 50)/2 - 50))
        baseAnimation.duration = 2.0
        // 如果fillMode=kCAFillModeForwards和isRemovedOnCompletion=false，那么在动画执行完毕后，图层会保持显示动画执行后的状态。但在实质上，图层的属性值还是动画执行前的初始值，并没有真正被改变。
        // baseAnimation.fillMode = kCAFillModeForwards
        // baseAnimation.isRemovedOnCompletion = false
        self.animateView.layer.add(baseAnimation, forKey: "positionAnimation")
        
        /// 方法二
        //        self.animateView.frame.origin.x = 0
        //        UIView.animate(withDuration: 2.0, delay: 0, options: .curveLinear, animations: {
        //            self.animateView.frame.origin.x = kScreenW
        //        }) { (finished) in
        //
        //        }
    }
    
    /// 透明度
    func opacityAniamtion() {
        let baseAnimation = CABasicAnimation(keyPath: "opacity")
        baseAnimation.fromValue = NSNumber(value: 1.0)
        baseAnimation.toValue = NSNumber(value: 0.2)
        baseAnimation.duration = 1.0
        self.animateView.layer.add(baseAnimation, forKey: "opacityAnimation")
    }
    
    /// 缩放
    func scaleAniamtion() {
        
        /// 方法一
        let baseAnimation = CABasicAnimation(keyPath: "transform.scale")
        baseAnimation.toValue = NSNumber(value: 2.0)
        baseAnimation.duration = 1.0
        self.animateView.layer.add(baseAnimation, forKey: "scaleAnimation")
        
        
        /// 方法二
        //        let baseAnimation = CABasicAnimation(keyPath: "bounds")
        //        baseAnimation.toValue = NSValue(cgRect: CGRect(x: 0, y: 0, width: 200, height: 200))
        //        baseAnimation.duration = 1.0
        //        self.animateView.layer.add(baseAnimation, forKey: "scaleAnimation")
    }
    
    /// 旋转
    func transAniamtion() {
        
        /// 方法一
        /// "transform.rotation"
        /// "transform.rotation.z"：绕着矢量（x,y,z）旋转
        let baseAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        baseAnimation.toValue = Double.pi * 4
        baseAnimation.duration = 2.0
        self.animateView.layer.add(baseAnimation, forKey: "rotationAnimation")
        
        /// 方法二
        //        let baseAnimation = CABasicAnimation(keyPath: "transform")
        //        baseAnimation.toValue = NSValue(caTransform3D: CATransform3DMakeRotation(CGFloat(Double.pi), 0, 0, 1))
        //        baseAnimation.duration = 2.0
        //        self.animateView.layer.add(baseAnimation, forKey: "rotationAnimation")
    }
    
    /// 背景色
    func backgroundAniamtion() {
        let baseAnimation = CABasicAnimation(keyPath: "backgroundColor")
        baseAnimation.toValue = UIColor.blue.cgColor
        baseAnimation.duration = 1.0
        self.animateView.layer.add(baseAnimation, forKey: "backgroundColorAnimation")
    }
}

