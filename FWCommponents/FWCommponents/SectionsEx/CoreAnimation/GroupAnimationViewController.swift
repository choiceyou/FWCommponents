//
//  GroupAnimationViewController
//  FWCommponents
//
//  Created by xfg on 2018/4/16.
//  Copyright © 2018年 xfg. All rights reserved.
//

import Foundation
import UIKit

class GroupAnimationViewController: AnimationBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "动画组"
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.itemTitleArray = ["同时", "连续"]
        self.setupItemBtn()
        
        self.animateViewWidth = 50
        self.view.addSubview(self.animateView)
    }
    
    override func btnAction(btn: UIButton) {
        switch btn.tag {
        case 0:
            self.groupAnimation1()
            break
        case 1:
            self.groupAnimation2()
            break
        default:
            break
        }
    }
}

extension GroupAnimationViewController {
    
    /// 同时
    func groupAnimation1() {
        // 位移动画
        let animation0 = CAKeyframeAnimation(keyPath: "position")
        let value0 = NSValue(cgPoint: CGPoint(x: 0, y: kScreenH/4))
        let value1 = NSValue(cgPoint: CGPoint(x: kScreenW/4, y: kScreenH/2-50))
        let value2 = NSValue(cgPoint: CGPoint(x: kScreenW/3, y: kScreenH/2+50))
        let value3 = NSValue(cgPoint: CGPoint(x: kScreenW/2, y: kScreenH/2+100))
        let value4 = NSValue(cgPoint: CGPoint(x: kScreenW/2+100, y: kScreenH/6))
        animation0.values = [value0, value1, value2, value3, value4]
        
        // 缩放动画
        let animation1 = CABasicAnimation(keyPath: "transform.scale")
        animation1.toValue = NSNumber(value: 2.0)
        
        // 旋转动画
        let animation2 = CABasicAnimation(keyPath: "transform.rotation.z")
        animation2.toValue = Double.pi * 4
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [animation0, animation1, animation2]
        animationGroup.duration = 2.0
        self.animateView.layer.add(animationGroup, forKey: "animationGroup")
    }
    
    /// 连续
    func groupAnimation2() {
        let currentTime = CACurrentMediaTime()
        
        // 位移动画
        let animation0 = CAKeyframeAnimation(keyPath: "position")
        let value0 = NSValue(cgPoint: CGPoint(x: 0, y: kScreenH/4))
        let value1 = NSValue(cgPoint: CGPoint(x: kScreenW/4, y: kScreenH/2-50))
        let value2 = NSValue(cgPoint: CGPoint(x: kScreenW/3, y: kScreenH/2+50))
        let value3 = NSValue(cgPoint: CGPoint(x: kScreenW/2, y: kScreenH/2+100))
        let value4 = NSValue(cgPoint: CGPoint(x: kScreenW/2+100, y: kScreenH/6))
        animation0.values = [value0, value1, value2, value3, value4]
        animation0.beginTime = currentTime
        animation0.duration = 1.0
        animation0.fillMode = kCAFillModeForwards
        animation0.isRemovedOnCompletion = false
        self.animateView.layer.add(animation0, forKey: "positionAnimation")
        
        // 缩放动画
        let animation1 = CABasicAnimation(keyPath: "transform.scale")
        animation1.toValue = NSNumber(value: 2.0)
        animation1.beginTime = currentTime + 1.0
        animation1.duration = 1.0
        animation1.fillMode = kCAFillModeForwards
        animation1.isRemovedOnCompletion = false
        self.animateView.layer.add(animation1, forKey: "scaleAnimation")

        // 旋转动画
        let animation2 = CABasicAnimation(keyPath: "transform.rotation.z")
        animation2.toValue = Double.pi * 4
        animation2.beginTime = currentTime + 2.0
        animation2.duration = 1.0
        animation2.fillMode = kCAFillModeForwards
        animation2.isRemovedOnCompletion = false
        self.animateView.layer.add(animation2, forKey: "rotationAnimation")
    }
}
