//
//  KeyframeAnimationViewController.swift
//  FWCommponents
//
//  Created by xfg on 2018/4/16.
//  Copyright © 2018年 xfg. All rights reserved.
//

import Foundation
import UIKit

class KeyframeAnimationViewController: AnimationBaseViewController, CAAnimationDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "关键帧动画"
        
        self.itemTitleArray = ["关键帧", "路径", "左右抖动", "上下抖动"]
        self.setupItemBtn()
        
        self.animateViewWidth = 50
        self.view.addSubview(self.animateView)
    }
    
    override func btnAction(btn: UIButton) {
        switch btn.tag {
        case 0:
            self.keyFrameAnimation()
            break
        case 1:
            self.pathAnimation()
            break
        case 2:
            self.shakeLRAnimation()
            break
        case 3:
            self.shakeTBAnimation()
            break
        default:
            break
        }
    }
}

extension KeyframeAnimationViewController {
    
    /// 关键帧动画
    func keyFrameAnimation() {
        let keyframeAnimation = CAKeyframeAnimation(keyPath: "position")
        let value0 = NSValue(cgPoint: CGPoint(x: 0, y: kScreenH/4))
        let value1 = NSValue(cgPoint: CGPoint(x: kScreenW/4, y: kScreenH/2-50))
        let value2 = NSValue(cgPoint: CGPoint(x: kScreenW/3, y: kScreenH/2+50))
        let value3 = NSValue(cgPoint: CGPoint(x: kScreenW/2, y: kScreenH/2+100))
        let value4 = NSValue(cgPoint: CGPoint(x: kScreenW/2+100, y: kScreenH/6))
        keyframeAnimation.values = [value0, value1, value2, value3, value4]
        keyframeAnimation.duration = 2.0
        // 设置动画的节奏
        keyframeAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        // 可监听动画的开始、结束
        keyframeAnimation.delegate = self
        self.animateView.layer.add(keyframeAnimation, forKey: "positionAnimation")
    }
    
    /// 路径
    func pathAnimation() {
        let keyframeAnimation = CAKeyframeAnimation(keyPath: "position")
        // 贝塞尔曲线
        let path = UIBezierPath(ovalIn: CGRect(x: kScreenW/2-100, y: kScreenH/2-100, width: 200, height: 200))
        keyframeAnimation.path = path.cgPath
        keyframeAnimation.duration = 2.0
        self.animateView.layer.add(keyframeAnimation, forKey: "positionAnimation")
    }
    
    /// 左右抖动
    func shakeLRAnimation() {
        let keyframeAnimation = CAKeyframeAnimation(keyPath: "transform.rotation")
        let value0 = NSNumber(value: -Double.pi/180*4)
        let value1 = NSNumber(value: Double.pi/180*4)
        let value2 = NSNumber(value: -Double.pi/180*4)
        keyframeAnimation.values = [value0, value1, value2]
        keyframeAnimation.repeatCount = 5
        self.animateView.layer.add(keyframeAnimation, forKey: "rotationAnimation")
    }
    
    /// 上下抖动
    func shakeTBAnimation() {
        let keyframeAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        keyframeAnimation.values = [1.1, 1.2, 1.0, 1.25, 1.0]
        keyframeAnimation.duration = 0.2
        self.animateView.layer.add(keyframeAnimation, forKey: "scaleAnimation")
    }
}

// MARK: - 实现动画代理
extension KeyframeAnimationViewController {
    
    func animationDidStart(_ anim: CAAnimation) {
        print("动画开始")
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        print("动画结束")
    }
}
