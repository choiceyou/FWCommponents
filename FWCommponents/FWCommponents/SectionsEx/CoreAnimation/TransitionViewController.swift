//
//  TransitionViewController.swift
//  FWCommponents
//
//  Created by xfg on 2018/4/16.
//  Copyright © 2018年 xfg. All rights reserved.
//

import Foundation
import UIKit

class TransitionViewController: AnimationBaseViewController {
    
    var index = 0
    
    
    lazy var animateLabel: UILabel = {
        
        let label = UILabel(frame: CGRect(x: (kScreenW - animateViewWidth)/2, y: (self.view.frame.height - animateViewWidth)/2 - 50, width: animateViewWidth, height: animateViewWidth))
        label.backgroundColor = UIColor.red
        label.font = UIFont.systemFont(ofSize: 25.0)
        label.textAlignment = .center
        label.textColor = UIColor.white
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "过渡动画"
        
        self.itemTitleArray = ["fade", "moveIn", "push", "reveal"]
        self.setupItemBtn()
        
        self.animateViewWidth = 150
        self.animateLabel.text = "0"
        self.view.addSubview(self.animateLabel)
    }
    
    override func btnAction(btn: UIButton) {
        switch btn.tag {
        case 0:
            self.fadeAnimation()
            break
        case 1:
            self.moveInAnimation()
            break
        case 2:
            self.pushAnimation()
            break
        case 3:
            self.revealAnimation()
            break
        default:
            break
        }
    }
}


extension TransitionViewController {
    
    /// 逐渐消失效果
    func fadeAnimation() {
        self.changeView(isUp: true)
        
        let transition = CATransition()
        // 设置动画的类型
        transition.type = kCATransitionFade
        // 设置动画的方向
        transition.subtype = kCATransitionFromRight
        transition.duration = 1.0
        self.animateLabel.layer.add(transition, forKey: "fadeTransition")
    }
    
    /// 进入覆盖效果
    func moveInAnimation() {
        self.changeView(isUp: true)
        
        let transition = CATransition()
        transition.type = kCATransitionMoveIn
        transition.subtype = kCATransitionFromRight
        transition.duration = 1.0
        self.animateLabel.layer.add(transition, forKey: "moveInTransition")
    }
    
    /// 推出效果
    func pushAnimation() {
        self.changeView(isUp: true)
        
        let transition = CATransition()
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        transition.duration = 1.0
        self.animateLabel.layer.add(transition, forKey: "moveInTransition")
    }
    
    /// 揭露离开效果
    func revealAnimation() {
        self.changeView(isUp: true)
        
        let transition = CATransition()
        transition.type = kCATransitionReveal
        transition.subtype = kCATransitionFromRight
        transition.duration = 1.0
        self.animateLabel.layer.add(transition, forKey: "moveInTransition")
    }
    
    func changeView(isUp: Bool) {
        if self.index > 3 {
            self.index = 0
        }
        
        if self.index < 0 {
            self.index = 3
        }
        
        let colors = [UIColor.cyan, UIColor.magenta, UIColor.orange, UIColor.purple]
        let titles = ["1", "2", "3", "4"]
        self.animateLabel.backgroundColor = colors[self.index]
        self.animateLabel.text = titles[self.index]
        
        if isUp {
            self.index += 1
        } else {
            self.index -= 1
        }
    }
}
