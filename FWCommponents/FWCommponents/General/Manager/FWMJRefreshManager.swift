//
//  FWMJRefreshManager.swift
//  FanweApps
//
//  Created by xfg on 2018/2/2.
//  Copyright © 2018年 xfg. All rights reserved.
//

import Foundation
import UIKit
import MJRefresh

class FWMJRefreshManager: NSObject {
    
    class func refresh(refreshedView: UIScrollView, target: Any, headerRereshAction: Selector?, footerRereshAction:Selector?) {
        self.refresh(refreshedView: refreshedView, target: target, headerRereshAction: headerRereshAction, shouldHeaderBeginRefresh: true, footerRereshAction: footerRereshAction)
    }
    
    class func refresh(refreshedView: UIScrollView, target: Any, headerRereshAction: Selector?, shouldHeaderBeginRefresh: Bool, footerRereshAction:Selector?) {
        self.refresh(refreshedView: refreshedView, target: target, headerRereshAction: headerRereshAction, shouldHeaderBeginRefresh: shouldHeaderBeginRefresh, footerRereshAction: footerRereshAction, refreshFooterType: "MJRefreshBackNormalFooter")
    }
    
    class func refresh(refreshedView: UIScrollView, target: Any, headerRereshAction: Selector?, shouldHeaderBeginRefresh: Bool, footerRereshAction:Selector?, refreshFooterType: String) {
        self.refresh(refreshedView: refreshedView, target: target, headerRereshAction: headerRereshAction, shouldHeaderBeginRefresh: shouldHeaderBeginRefresh, headerWithRefreshingBlock: nil, footerRereshAction: footerRereshAction, refreshFooterType: refreshFooterType)
    }
    
    class func refresh(refreshedView: UIScrollView, target: Any, headerRereshAction: Selector?, shouldHeaderBeginRefresh: Bool, headerWithRefreshingBlock: FWVoidBlock?, footerRereshAction:Selector?, refreshFooterType: String?) {
        
        if headerRereshAction != nil || headerWithRefreshingBlock != nil {
            let header: MJRefreshGifHeader!
            if headerWithRefreshingBlock != nil {
                header = MJRefreshGifHeader.init(refreshingBlock: {
                    headerWithRefreshingBlock!()
                })
            } else {
                header = MJRefreshGifHeader.init(refreshingTarget: target, refreshingAction: headerRereshAction)
            }
            
            header.lastUpdatedTimeLabel.isHidden = true
            header.stateLabel.isHidden = true
            
            var idleImages: [UIImage] = []
            for index in (1..<61) {
                idleImages.append(UIImage.init(named: "dropdown_anim__000\(index)")!)
            }
            header.setImages(idleImages, for: .idle)
            
            var progressImages: [UIImage] = []
            for index in (1..<4) {
                progressImages.append(UIImage.init(named: "dropdown_loading_0\(index)")!)
            }
            header.setImages(progressImages, duration: 0.1 * Double(progressImages.count), for: .refreshing)
            refreshedView.mj_header = header
            
            if shouldHeaderBeginRefresh {
                header.beginRefreshing()
            }
        } else {
            refreshedView.mj_header = nil
        }
        
        if (footerRereshAction != nil) {
            if refreshFooterType != nil && !(refreshFooterType?.isEmpty)! {
                let className = NSClassFromString(refreshFooterType!) as! MJRefreshFooter.Type
                refreshedView.mj_footer = className.init(refreshingTarget: target, refreshingAction: footerRereshAction)
            } else {
                refreshedView.mj_footer = MJRefreshBackNormalFooter.init(refreshingTarget: target, refreshingAction: footerRereshAction)
            }
        } else {
            refreshedView.mj_footer = nil
        }
    }
    
    class func beginHeaderRefresh(refreshedView: UIScrollView) {
        
        if refreshedView.mj_header != nil && refreshedView.mj_header.isRefreshing {
            refreshedView.mj_header.endRefreshing()
        }
        
        if refreshedView.mj_header != nil {
            refreshedView.mj_header.beginRefreshing()
        }
    }
    
    class func endRefresh(refreshedView: UIScrollView?) {
        
        if refreshedView == nil {
            return
        }
        
        if refreshedView?.mj_header != nil {
            refreshedView?.mj_header.endRefreshing()
        }
        
        if refreshedView?.mj_footer != nil {
            refreshedView?.mj_footer.endRefreshing()
        }
    }
}
