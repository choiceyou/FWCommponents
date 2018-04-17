//
//  PathButton.swift
//  FWCommponents
//
//  Created by xfg on 2018/4/17.
//  Copyright © 2018年 xfg. All rights reserved.
//

import Foundation
import UIKit

protocol PathButtonDelegate {
    
    func itemBtnTapped(index: Int)
}

class PathButton: UIView {
    
    var pathButtonDelegate: PathButtonDelegate?
    
    
}
