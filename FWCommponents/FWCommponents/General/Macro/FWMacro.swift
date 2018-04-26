//
//  FWMacro.swift
//  FWCommponents
//
//  Created by xfg on 2018/4/16.
//  Copyright © 2018年 xfg. All rights reserved.
//

import Foundation
import UIKit


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



// MARK: - ----------------------- 闭包 -----------------------

/// 无参数闭包
typealias FWVoidBlock = ()->Void
/// 通用的完成回调
typealias FWIsFinishedBlock = (_ isFinished: Bool)->Void
/// 通用的错误回调
typealias FWErrorBlock = (_ errCode: Int, _ errMsg: String?)->Void

