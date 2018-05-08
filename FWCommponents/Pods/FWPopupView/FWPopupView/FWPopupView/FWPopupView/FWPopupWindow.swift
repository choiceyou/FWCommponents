//
//  FWPopupWindow.swift
//  FWPopupView
//
//  Created by xfg on 2018/3/19.
//  Copyright © 2018年 xfg. All rights reserved.
//

import Foundation
import UIKit

public func kPV_RGBA (r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}

open class FWPopupWindow: UIWindow, UIGestureRecognizerDelegate {
    
    /// 单例
    @objc open static let sharedInstance = FWPopupWindow()
    
    // default is NO. When YES, popup views will be hidden when user touch the translucent background.
    @objc var touchWildToHide: Bool = false
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.frame = UIScreen.main.bounds
        
        let rootVC = UIViewController()
        rootVC.view.backgroundColor = UIColor.clear
        self.rootViewController = rootVC
        
        self.windowLevel = UIWindowLevelStatusBar + 1
        
        let tapGest = UITapGestureRecognizer.init(target: self, action: #selector(tapGesClick(tap:)))
        tapGest.cancelsTouchesInView = false
        tapGest.delegate = self
        self.addGestureRecognizer(tapGest)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FWPopupWindow {
 
    @objc func tapGesClick(tap: UITapGestureRecognizer) {
        
        if self.touchWildToHide && !self.fwBackgroundAnimating {
            for view: UIView in (self.attachView()?.fwBackgroundView.subviews)! {
                if view.isKind(of: FWPopupView.self) {
                    let popupView = view as! FWPopupView
                    popupView.hide()
                }
            }
        }
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view == self.attachView()?.fwBackgroundView
    }
    
    public func attachView() -> UIView? {
        if self.rootViewController != nil {
            return self.rootViewController?.view
        } else {
            return nil
        }
    }
}
