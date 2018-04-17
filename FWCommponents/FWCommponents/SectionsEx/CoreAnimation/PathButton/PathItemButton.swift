//
//  PathItemButton.swift
//  FWCommponents
//
//  Created by xfg on 2018/4/17.
//  Copyright © 2018年 xfg. All rights reserved.
//

import Foundation
import UIKit

protocol PathItemButtonDelegate {
    
    func itemBtnTapped(itemBtn: PathItemButton)
}

class PathItemButton: UIImageView {
    
    var pathItemButtonDelegate: PathItemButtonDelegate?
    var index = 0
    var backgroundImageView: UIImageView!
    
    
    func pathItem(image: UIImage, highlightedImage: UIImage, backgroundImage: UIImage, backgroundHighlightedImage: UIImage) {
        
        let itemFrame = CGRect(x: 0, y: 0, width: backgroundImage.size.width, height: backgroundImage.size.height)
        
        self.frame = itemFrame
        
        self.image = backgroundImage
        self.highlightedImage = backgroundHighlightedImage
        
        self.isUserInteractionEnabled = true
        
        self.backgroundImageView = UIImageView(image: image, highlightedImage: highlightedImage)
        self.backgroundImageView.center = CGPoint(x: itemFrame.width/2, y: itemFrame.height/2)
        
        self.addSubview(self.backgroundImageView)
    }
}


extension PathItemButton {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.isHighlighted = true
        self.backgroundImageView.isHighlighted = true
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let currentLocation = touches.first?.location(in: self)
        
        if currentLocation != nil && self.scaleRect(originRect: self.bounds).contains(currentLocation!) {
            self.isHighlighted = false
            self.backgroundImageView.isHighlighted = false
            return
        }
        
        self.isHighlighted = false
        self.backgroundImageView.isHighlighted = false
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if self.pathItemButtonDelegate != nil {
            self.pathItemButtonDelegate?.itemBtnTapped(itemBtn: self)
        }
        
        self.isHighlighted = false
        self.backgroundImageView.isHighlighted = false
    }
    
    func scaleRect(originRect: CGRect) -> CGRect {
        return CGRect(x: -originRect.width, y: -originRect.height, width: originRect.width * 5, height: originRect.height * 5)
    }
}
