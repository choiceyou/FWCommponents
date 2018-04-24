//
//  FWViewControllerProtocol.swift
//  FWCommponents
//
//  Created by xfg on 2018/4/24.
//  Copyright © 2018年 xfg. All rights reserved.
//

import Foundation
import UIKit

@objc public protocol FWViewControllerProtocol {
    
    @objc optional func fw_bindViewModel()
    @objc optional func fw_setupViews()
}
