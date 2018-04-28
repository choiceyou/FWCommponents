//
//  FWMacro.swift
//  FWCommponents
//
//  Created by xfg on 2018/4/16.
//  Copyright © 2018年 xfg. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ----------------------- 颜色方法 -----------------------

func kRGB (r:CGFloat, g:CGFloat, b:CGFloat) -> UIColor {
    return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1)
}

func kRGBA (r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}

//func UIColorHex(rgbValue: UInt) -> UIColor {
//    return UIColor(
//        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
//        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
//        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
//        alpha: CGFloat(1.0)
//    )
//}

func UIColorHex(hexString: String) -> UIColor{
    
    var cString: String = hexString.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
    
    if cString.count < 6 {
        return UIColor.black
    }
    if cString.hasPrefix("0X") {
        cString = cString.substring(from: cString.index(cString.startIndex, offsetBy: 2))
    }
    if cString.hasPrefix("#") {
        cString = cString.substring(from: cString.index(cString.startIndex, offsetBy: 1))
    }
    if cString.count != 6 {
        return UIColor.black
    }
    
    var range: NSRange = NSMakeRange(0, 2)
    let rString = (cString as NSString).substring(with: range)
    range.location = 2
    let gString = (cString as NSString).substring(with: range)
    range.location = 4
    let bString = (cString as NSString).substring(with: range)
    
    var r: UInt32 = 0x0
    var g: UInt32 = 0x0
    var b: UInt32 = 0x0
    Scanner.init(string: rString).scanHexInt32(&r)
    Scanner.init(string: gString).scanHexInt32(&g)
    Scanner.init(string: bString).scanHexInt32(&b)
    
    return UIColor(displayP3Red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: CGFloat(1))
    
}


// MARK: - ----------------------- System -----------------------

/// 状态栏高度
let kStatusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
/// 导航栏高度
let kNavBarHeight: CGFloat = 44.0
/// 状态栏+导航栏的高度
let kStatusAndNavBarHeight: CGFloat = (kStatusBarHeight + kNavBarHeight)
/// 底部菜单栏高度
let kTabBarHeight: CGFloat = (UIApplication.shared.statusBarFrame.size.height > 20.0 ? 83.0:49.0)

/// 屏幕宽度
let kScreenW: CGFloat = UIScreen.main.bounds.width
/// 屏幕高度
let kScreenH: CGFloat = UIScreen.main.bounds.height
let kScreenScale = UIScreen.main.scale



// MARK: - ----------------------- 闭包 -----------------------

/// 无参数闭包
typealias FWVoidBlock = ()->Void
/// 通用的完成回调
typealias FWIsFinishedBlock = (_ isFinished: Bool)->Void
/// 通用的错误回调
typealias FWErrorBlock = (_ errCode: Int, _ errMsg: String?)->Void

