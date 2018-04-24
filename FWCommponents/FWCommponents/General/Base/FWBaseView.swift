//
//  FWBaseView.swift
//  FWCommponents
//
//  Created by xfg on 2018/4/24.
//  Copyright © 2018年 xfg. All rights reserved.
//

import Foundation
import UIKit

class FWBaseView: UIView, FWViewProtocol {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.fw_bindViewModel()
        self.fw_setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fw_setupViews() {
        
    }
    
    func fw_bindViewModel() {
        
    }
}
