//
//  PathButton.swift
//  FWCommponents
//
//  Created by xfg on 2018/4/17.
//  Copyright © 2018年 xfg. All rights reserved.
//

import Foundation
import UIKit

public protocol PathButtonDelegate {
    
    func itemBtnTapped(index: Int)
}

open class PathButton: UIView, PathCenterButtonDelegate, PathItemButtonDelegate, CAAnimationDelegate {
    
    public var pathButtonDelegate: PathButtonDelegate?
    
    public var bloomRadius: CGFloat = 105.0
    
    
    private var centerImage: UIImage!
    private var centerHighlightedImage: UIImage!
    
    private var pathCenterButton: PathCenterButton!
    
    private var foldedSize = CGSize(width: 0, height: 0)
    private var bloomSize = UIScreen.main.bounds.size
    
    private var foldCenter = CGPoint(x: 0, y: 0)
    private var bloomCenter = CGPoint(x: 0, y: 0)
    
    private var pathCenterButtonBloomCenter = CGPoint(x: 0, y: 0)
    
    private var bloom = false
    
    private var bottomView: UIView!
    
    private var itemButtons: [PathItemButton] = []
    
    
    public func setup(centerImage: UIImage, highlightedImage: UIImage) {
        
        self.centerImage = centerImage
        self.centerHighlightedImage = highlightedImage
        
        self.setupUI()
    }
    
    func setupUI() {
        
        self.foldedSize = self.centerImage.size
        
        self.foldCenter = CGPoint(x: self.bloomSize.width / 2, y: self.bloomSize.height - 225.5)
        self.bloomCenter = CGPoint(x: self.bloomSize.width / 2, y: self.bloomSize.height / 2)
        
        self.frame = CGRect(x: 0, y: 0, width: self.foldedSize.width, height: self.foldedSize.height)
        self.center = self.foldCenter
        
        self.pathCenterButton = PathCenterButton(image: self.centerImage, highlightedImage: self.centerHighlightedImage)
        self.pathCenterButton.center = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        self.pathCenterButton.pathCenterButtonDelegate = self
        self.addSubview(self.pathCenterButton)
        
        self.bottomView = UIView(frame: CGRect(x: 0, y: 0, width: self.bloomSize.width, height: self.bloomSize.height))
        self.bottomView.backgroundColor = UIColor.black
        self.bottomView.alpha = 0.0
    }
    
    public func addPathItems(pathItems: [PathItemButton]) {
        
        self.itemButtons = pathItems
    }
}

// MARK: - 实现代理
extension PathButton {
    
    public func clickCenterBtn() {
        if self.bloom {
            self.pathCenterButtonFold()
        } else {
            self.pathCenterButtonBloom()
        }
    }
    
    func itemBtnTapped(itemBtn: PathItemButton) {
        
    }
}

// MARK: - 动画收缩、展开
extension PathButton {
    
    private func createEndPoint(itemExpandRadius: CGFloat, angel: CGFloat) -> CGPoint {
        return CGPoint(x: self.pathCenterButtonBloomCenter.x - CGFloat(cosf(Float(angel * CGFloat(Double.pi)))) * itemExpandRadius, y: self.pathCenterButtonBloomCenter.y - CGFloat(sinf(Float(angel * CGFloat(Double.pi)))) * itemExpandRadius)
    }
    
    /// 开始收缩动画
    private func pathCenterButtonFold() {
        
        var index = 0
        for pathItembtn in self.itemButtons {
            
            let currentAngel: CGFloat = CGFloat(index + 1) / CGFloat(self.itemButtons.count + 1)
            let farPoint = self.createEndPoint(itemExpandRadius: self.bloomRadius + 5.0, angel: CGFloat(currentAngel))
            
            let foldAnimation = self.foldAnimation(endPoint: pathItembtn.center, farPoint: farPoint)
            
            pathItembtn.layer.add(foldAnimation, forKey: "foldAnimation")
            pathItembtn.center = self.pathCenterButtonBloomCenter
            
            index += 1
        }
        
        self.bringSubview(toFront: self.pathCenterButton)
        
        self.resizeToFoldedFrame()
    }
    
    /// 真正收缩动画
    ///
    /// - Parameters:
    ///   - endPoint: 起点
    ///   - farPoint: 终点
    /// - Returns: 动画组
    private func foldAnimation(endPoint: CGPoint, farPoint: CGPoint) -> CAAnimationGroup {
        
        /// 旋转动画
        let rotationAnimation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.values = [0, Double.pi, Double.pi*1.5, Double.pi*2]
        rotationAnimation.keyTimes = [0.0, 0.3, 0.6, 1.0]
        rotationAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        rotationAnimation.duration = 0.35
        
        /// 移动
        let movingAnimation = CAKeyframeAnimation(keyPath: "position")
        let path = CGMutablePath()
        path.move(to: endPoint)
        path.addLines(between: [farPoint, self.pathCenterButtonBloomCenter])
        movingAnimation.keyTimes = [0.0, 0.75, 1.0]
        movingAnimation.path = path
        movingAnimation.duration = 0.35
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [rotationAnimation, movingAnimation]
        animationGroup.duration = 0.35
        
        return animationGroup
    }
    
    private func resizeToFoldedFrame() {
        
        UIView.animate(withDuration: 0.0618 * 3, delay: 0.0618 * 2, options: .curveLinear, animations: {
            self.pathCenterButton.transform = CGAffineTransform(rotationAngle: 0)
        }) { (finished) in
            
        }
        
        UIView.animate(withDuration: 0.1, delay: 0.35, options: .curveLinear, animations: {
            self.bottomView.alpha = 0.0
        }) { (finished) in
            
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            DispatchQueue.main.async {
                
                for pathItembtn in self.itemButtons {
                    pathItembtn.removeFromSuperview()
                }
                
                self.frame = CGRect(x: 0, y: 0, width: self.foldedSize.width, height: self.foldedSize.height)
                self.center = self.foldCenter
                self.pathCenterButton.center = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
                
                self.bottomView.removeFromSuperview()
            }
        }
        
        self.bloom = false
    }
    
    /// 展开动画
    private func pathCenterButtonBloom() {
        
        self.pathCenterButtonBloomCenter = self.center
        
        self.frame = CGRect(x: 0, y: 0, width: self.bloomSize.width, height: self.bloomSize.height)
        self.center = CGPoint(x: self.bloomSize.width/2, y: self.bloomSize.height/2)
        
        self.insertSubview(self.bottomView, belowSubview: self.pathCenterButton)
        
        UIView.animate(withDuration: 0.0618, delay: 0.0, options: .curveLinear, animations: {
            self.bottomView.alpha = 0.618
        }) { (finished) in
            
        }
        
        UIView.animate(withDuration: 0.1575) {
            self.pathCenterButton.transform = CGAffineTransform(rotationAngle: CGFloat(-0.75 * Double.pi))
        }
        
        self.pathCenterButton.center = self.pathCenterButtonBloomCenter
        
        let basicAngel: CGFloat = CGFloat(180 / (self.itemButtons.count + 1))
        
        var index = 0
        for pathItembtn in self.itemButtons {
            
            pathItembtn.pathItemButtonDelegate = self
            pathItembtn.tag = index
            pathItembtn.transform = CGAffineTransform(translationX: 1, y: 1)
            pathItembtn.alpha = 1.0
            
            let currentAngel: CGFloat = CGFloat((basicAngel * CGFloat((index + 1))) / 180)
            
            pathItembtn.center = self.pathCenterButtonBloomCenter
            self.insertSubview(pathItembtn, belowSubview: self.pathCenterButton)
            
            let endPoint = self.createEndPoint(itemExpandRadius: self.bloomRadius, angel: CGFloat(currentAngel))
            let farPoint = self.createEndPoint(itemExpandRadius: self.bloomRadius + 10.0, angel: CGFloat(currentAngel))
            let nearPoint = self.createEndPoint(itemExpandRadius: self.bloomRadius - 5.0, angel: CGFloat(currentAngel))
            
            let bloomAnimation = self.bloomAnimation(endPoint: endPoint, farPoint: farPoint, nearPoint: nearPoint)
            pathItembtn.layer.add(bloomAnimation, forKey: "bloomAnimation")
            pathItembtn.center = endPoint
            
            index += 1
        }
        
        self.bloom = true
    }
    
    /// 真正展开动画
    ///
    /// - Parameters:
    ///   - endPoint: 起点
    ///   - farPoint: 终点
    ///   - nearPoint: 回弹效果点
    /// - Returns: 动画组
    private func bloomAnimation(endPoint: CGPoint, farPoint: CGPoint, nearPoint: CGPoint) -> CAAnimationGroup {
        
        /// 旋转动画
        let rotationAnimation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.values = [0.0, -Double.pi, -Double.pi*1.5, -Double.pi*2]
        rotationAnimation.duration = 0.3
        rotationAnimation.keyTimes = [0.0, 0.3, 0.6, 1.0]
        
        /// 移动
        let movingAnimation = CAKeyframeAnimation(keyPath: "position")
        let path = CGMutablePath()
        path.move(to: endPoint)
        path.addLines(between: [farPoint, nearPoint, endPoint])
        movingAnimation.path = path
        movingAnimation.keyTimes = [0.0, 0.5, 0.7, 1.0]
        movingAnimation.duration = 0.3
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [rotationAnimation, movingAnimation]
        animationGroup.duration = 0.3
        animationGroup.delegate = self
        
        return animationGroup
    }
}
