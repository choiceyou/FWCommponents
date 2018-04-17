//
//  PathCenterButton.swift
//  FWCommponents
//
//  Created by xfg on 2018/4/17.
//  Copyright © 2018年 xfg. All rights reserved.
//

import Foundation
import UIKit

@objc public protocol PathCenterButtonDelegate {
    
    @objc optional func clickCenterBtn()
}

class PathCenterButton: UIImageView {
    
    var pathCenterButtonDelegate: PathCenterButtonDelegate?
    
    override init(image: UIImage?, highlightedImage: UIImage?) {
        super.init(image: image, highlightedImage: highlightedImage)
        
        self.isUserInteractionEnabled = true
        
        self.image = image
        self.highlightedImage = highlightedImage
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PathCenterButton {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.isHighlighted = true
        
        if self.pathCenterButtonDelegate != nil {
            self.pathCenterButtonDelegate!.clickCenterBtn!()
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let currentLocation = touches.first?.location(in: self)
        if currentLocation != nil && self.scaleRect(originRect: self.bounds).contains(currentLocation!) {
            self.isHighlighted = false
            return
        }
        
        self.isHighlighted = true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.isHighlighted = false
    }
    
    func scaleRect(originRect: CGRect) -> CGRect {
        return CGRect(x: -originRect.width, y: -originRect.height, width: originRect.width * 3, height: originRect.height * 3)
    }
}
