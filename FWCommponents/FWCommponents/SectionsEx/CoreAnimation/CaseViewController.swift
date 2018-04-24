//
//  CaseViewController.swift
//  FWCommponents
//
//  Created by xfg on 2018/4/17.
//  Copyright © 2018年 xfg. All rights reserved.
//

import Foundation
import UIKit

class CaseViewController: AnimationBaseViewController, PathButtonDelegate {
    
    var pathButton: PathButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "动画案例"
        
        self.itemTitleArray = ["Path", "钉钉", "点赞"]
        self.setupItemBtn()
        
        self.setupPath()
    }
    
    func setupPath() {
        
        self.pathButton = PathButton()
        self.pathButton.setup(centerImage: UIImage(named: "chooser-button-tab")!, highlightedImage: UIImage(named: "chooser-button-tab-highlighted")!)
        self.pathButton.pathButtonDelegate = self
        self.view.addSubview(self.pathButton)
        
        let pathItemButton0 = PathItemButton()
        pathItemButton0.setup(image: UIImage(named: "chooser-moment-icon-music")!, highlightedImage: UIImage(named: "chooser-moment-icon-music-highlighted")!, backgroundImage: UIImage(named: "chooser-moment-button")!, backgroundHighlightedImage: UIImage(named: "chooser-moment-button-highlighted")!)
        
        let pathItemButton1 = PathItemButton()
        pathItemButton1.setup(image: UIImage(named: "chooser-moment-icon-place")!, highlightedImage: UIImage(named: "chooser-moment-icon-place-highlighted")!, backgroundImage: UIImage(named: "chooser-moment-button")!, backgroundHighlightedImage: UIImage(named: "chooser-moment-button-highlighted")!)
        
        let pathItemButton2 = PathItemButton()
        pathItemButton2.setup(image: UIImage(named: "chooser-moment-icon-camera")!, highlightedImage: UIImage(named: "chooser-moment-icon-camera-highlighted")!, backgroundImage: UIImage(named: "chooser-moment-button")!, backgroundHighlightedImage: UIImage(named: "chooser-moment-button-highlighted")!)
        
        let pathItemButton3 = PathItemButton()
        pathItemButton3.setup(image: UIImage(named: "chooser-moment-icon-thought")!, highlightedImage: UIImage(named: "chooser-moment-icon-thought-highlighted")!, backgroundImage: UIImage(named: "chooser-moment-button")!, backgroundHighlightedImage: UIImage(named: "chooser-moment-button-highlighted")!)
        
        let pathItemButton4 = PathItemButton()
        pathItemButton4.setup(image: UIImage(named: "chooser-moment-icon-sleep")!, highlightedImage: UIImage(named: "chooser-moment-icon-sleep-highlighted")!, backgroundImage: UIImage(named: "chooser-moment-button")!, backgroundHighlightedImage: UIImage(named: "chooser-moment-button-highlighted")!)
        
        self.pathButton.addPathItems(pathItems: [pathItemButton0, pathItemButton1, pathItemButton2, pathItemButton3, pathItemButton4])
        
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
        self.pathButton.isHidden = false
    }
    
    /// 仿钉钉动画，后续有时间再实现
    func ddAnimation() {
        self.pathButton.isHidden = true
    }
    
    /// 点赞动画，后续有时间再实现
    func likeAnimation() {
        self.pathButton.isHidden = true
    }
}

extension CaseViewController {
    
    func itemBtnTapped(index: Int) {
        print("点击了第 \(index + 1) 项")
    }
}
