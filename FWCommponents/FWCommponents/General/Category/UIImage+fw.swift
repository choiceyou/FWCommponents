//
//  UIImage+fw.swift
//  FWCommponents
//
//  Created by xfg on 2018/4/27.
//  Copyright © 2018年 xfg. All rights reserved.
//

import Foundation
import UIKit

typealias ImageDrawBlock = (_ context: CGContext) -> Void

extension UIImage {
    
    class func image(size: CGSize, drawBlock: ImageDrawBlock? = nil) -> UIImage? {
        
        if drawBlock == nil {
            return nil
        }
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let context = UIGraphicsGetCurrentContext()
        if context == nil {
            return nil
        }
        drawBlock!(context!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
