//
//  AnimationBaseViewController.swift
//  FWCommponents
//
//  Created by xfg on 2018/4/16.
//  Copyright © 2018年 xfg. All rights reserved.
//

import Foundation
import UIKit
import FWCycleScrollView

class AnimationBaseViewController: UIViewController {
    
    var itemTitleArray: [String] = []
    var cycleScrollViewY = 0
    var cycleScrollViewHeight = 100
    
    
    lazy var cycleScrollView: FWCycleScrollView = {
        
        let cycleScrollView = FWCycleScrollView.cycle(frame: CGRect(x: 0, y: self.view.frame.height - 130, width: self.view.frame.width, height: 130), loopTimes: 1)
        cycleScrollView.currentPageDotEnlargeTimes = 1.0
        cycleScrollView.customDotViewType = .hollow
        cycleScrollView.pageDotColor = UIColor.red
        cycleScrollView.currentPageDotColor = UIColor.red
        cycleScrollView.pageControlDotSize = CGSize(width: 12, height: 12)
        cycleScrollView.autoScroll = false
        self.view.addSubview(cycleScrollView)
        return cycleScrollView
    }()
    
    func setupItemBtn() {
        
        var tmpX: CGFloat = 0
        var tmpY: CGFloat = 0
        
        let horizontalRow = 4
        let maxVerticalRow = 2
        
        let tmpW = self.view.frame.width / CGFloat(horizontalRow)
        let tmpH: CGFloat = 50
        
        var bottomView: UIView?
        
        var customSubViewArray: [UIView] = []
        
        for index in 0...(self.itemTitleArray.count-1) {
            
            tmpX = CGFloat(index % horizontalRow) * tmpW
            if (index % (horizontalRow * maxVerticalRow)) < horizontalRow {
                tmpY = 0
            } else {
                tmpY = tmpH
            }
            
            if bottomView == nil || (index % (horizontalRow * maxVerticalRow) == 0) {
                bottomView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 130))
                bottomView?.backgroundColor = UIColor.white
                customSubViewArray.append(bottomView!)
            }
            
            bottomView?.addSubview(self.setupBtn(index: index, frame: CGRect(x: tmpX, y: tmpY, width: tmpW, height: tmpH)))
        }
        
        self.cycleScrollView.viewArray = customSubViewArray
    }
    
    func setupBtn(index: Int, frame: CGRect) -> UIView {
        
        let view = UIView(frame: frame)
        
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: view.frame.width * 0.2 / 2, y: view.frame.height * 0.2 / 2, width: view.frame.width * 0.8, height: view.frame.height * 0.8)
        btn.setTitle(self.itemTitleArray[index], for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = UIColor.lightGray
        btn.tag = index
        btn.addTarget(self, action: #selector(btnAction(btn:)), for: .touchUpInside)
        view.addSubview(btn)
        
        return view
    }
    
    @objc func btnAction(btn: UIButton) {
        
    }
}
