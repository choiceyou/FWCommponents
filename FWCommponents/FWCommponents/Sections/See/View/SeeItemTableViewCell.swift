//
//  SeeItemTableViewCell.swift
//  FWCommponents
//
//  Created by xfg on 2018/4/24.
//  Copyright © 2018年 xfg. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

class SeeItemTableViewCell: UITableViewCell {
    
    var statusView: SeeStatusView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.statusView = SeeStatusView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 1))
        self.addSubview(self.statusView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupLayout(layout: SeeStatusLayout) {
        
        self.statusView.setupLayout(layout: layout)
    }
}


class SeeStatusView: UIView {
    
    /// 容器
    var contentView: UIView!
    /// 标题栏
    var titleView: SeeStatusTitleView!
    /// 用户资料
    var profileView: SeeStatusProfileView!
    /// VIP 自定义背景
    var vipBackgroundView: UIImageView!
    /// 菜单按钮
    var menuButton: UIButton!
    /// 关注按钮
    var followButton: UIButton!
    /// 转发容器
    var retweetBackgroundView: UIView!
    /// 文本
    var textLabel: UILabel!
    /// 转发文本
    var retweetTextLabel: UILabel!
    
    /// 图片
    var picViews: [UIView] = []
    
    /// 卡片
    var cardView: SeeStatusCardView!
    /// 下方Tag
    var tagView: SeeStatusTagView!
    /// 工具栏
    var toolbarView: SeeStatusToolbarView!
    
    var layout: SeeStatusLayout!
    
    
    override init(frame: CGRect) {
        if frame.width == 0 && frame.height == 0 {
            var tmpFrame = frame
            tmpFrame.size.width = kScreenW
            tmpFrame.size.height = 1
            super.init(frame: tmpFrame)
        } else {
            super.init(frame: frame)
        }
        
        self.backgroundColor = UIColor.clear
        self.isExclusiveTouch = true
        
        self.contentView = UIView()
        self.contentView.frame.size.width = self.frame.width
        self.contentView.frame.size.height = 1
        self.contentView.backgroundColor = UIColor.white
        self.addSubview(self.contentView)
        
        let topLine = UIImageView(frame: CGRect(x: 0, y: 0, width: self.contentView.frame.width, height: 1))
        topLine.image = FWUtilsManager.resizableImage(imageName: "com_line", edgeInsets: UIEdgeInsetsMake(0, 0, 0, 0))
        self.contentView.addSubview(topLine)
        
        self.titleView = SeeStatusTitleView()
        self.titleView.isHidden = true
        self.contentView.addSubview(self.titleView)
        
        self.profileView = SeeStatusProfileView()
        self.contentView.addSubview(self.profileView)
        
        self.vipBackgroundView = UIImageView(frame: CGRect(x: 0, y: -2, width: self.contentView.frame.width, height: 14.0))
        self.contentView.addSubview(self.vipBackgroundView)
        
        self.menuButton = UIButton(type: .custom)
        self.menuButton.frame = CGRect(x: self.contentView.frame.width - 35, y: 18, width: 30, height: 30)
        self.menuButton.setImage(UIImage(named: "timeline_icon_more"), for: .normal)
        self.menuButton.setImage(UIImage(named: "timeline_icon_more_highlighted"), for: .highlighted)
        self.menuButton.rx.controlEvent(.touchUpInside).subscribe(onNext: { [weak self] (_) in
            guard let strongSelf = self else {
                return
            }
        }).disposed(by: self.rx.disposeBag)
        self.contentView.addSubview(self.menuButton)
        
        self.retweetBackgroundView = UIView()
        self.retweetBackgroundView.backgroundColor = kSeeCellInnerViewColor
        self.contentView.addSubview(self.retweetBackgroundView)
        
        self.textLabel = UILabel()
        self.contentView.addSubview(self.textLabel)
        
        self.retweetTextLabel = UILabel()
        self.contentView.addSubview(self.retweetTextLabel)
        
        var tmpPicViews: [UIView] = []
        for index in 0...9 {
            
        }
        
        self.cardView = SeeStatusCardView()
        self.cardView.isHidden = true
        self.contentView.addSubview(self.cardView)
        
        self.tagView = SeeStatusTagView()
        self.tagView.isHidden = true
        self.contentView.addSubview(self.tagView)
        
        self.toolbarView = SeeStatusToolbarView()
        self.contentView.addSubview(self.toolbarView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupLayout(layout: SeeStatusLayout) {
        
        self.layout = layout
        
        
    }
}


/// 标题栏
class SeeStatusTitleView: UIView {
    
    
}

/// 用户资料
class SeeStatusProfileView: UIView {
    
    
}

/// 卡片
class SeeStatusCardView: UIView {
    
    
}

/// 下方Tag
class SeeStatusTagView: UIView {
    
    
}

/// 工具栏
class SeeStatusToolbarView: UIView {
    
    
}
