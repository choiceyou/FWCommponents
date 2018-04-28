//
//  SeeStatusTableViewCell.swift
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
import YYKit
import Kingfisher

class SeeStatusTableViewCell: UITableViewCell {
    
    var statusView: SeeStatusView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.statusView = SeeStatusView()
        self.statusView.tableViewCell = self
        self.contentView.addSubview(self.statusView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupLayout(layout: SeeStatusLayout) {
        
        self.frame.size.height = layout.height
        self.contentView.frame.size.height = layout.height
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
    var textLabel: YYLabel!
    /// 转发文本
    var retweetTextLabel: YYLabel!
    
    /// 图片
    var picViews: [UIView] = []
    
    /// 卡片
    var cardView: SeeStatusCardView!
    /// 下方Tag
    var tagView: SeeStatusTagView!
    /// 工具栏
    var toolbarView: SeeStatusToolbarView!
    
    var layout: SeeStatusLayout!
    
    var tableViewCell: SeeStatusTableViewCell!
    
    
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
        
        let topLine = UIImageView(image: FWUtilsManager.resizableImage(imageName: "com_line", edgeInsets: UIEdgeInsetsMake(0, 0, 0, 0)))
        topLine.width = self.contentView.width
        topLine.bottom = 0
        topLine.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        self.contentView.addSubview(topLine)
        
        let bottomLine = UIImageView(image: FWUtilsManager.resizableImage(imageName: "com_line", edgeInsets: UIEdgeInsetsMake(0, 0, 0, 0)))
        bottomLine.width = self.contentView.width
        bottomLine.top = self.contentView.height
        bottomLine.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        self.contentView.addSubview(bottomLine)
        
        self.titleView = SeeStatusTitleView()
        self.titleView.isHidden = true
        self.contentView.addSubview(self.titleView)
        
        self.profileView = SeeStatusProfileView()
        self.contentView.addSubview(self.profileView)
        
        self.vipBackgroundView = UIImageView()
        self.vipBackgroundView.size = CGSize(width: self.contentView.width, height: 14.0)
        self.vipBackgroundView.top = -2
        self.vipBackgroundView.contentMode = .topRight
        self.contentView.addSubview(self.vipBackgroundView)
        
        self.menuButton = UIButton(type: .custom)
        self.menuButton.size = CGSize(width: 30, height: 30)
        self.menuButton.centerX = self.width - 20
        self.centerY = 18
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
        self.retweetBackgroundView.width = self.contentView.width
        self.contentView.addSubview(self.retweetBackgroundView)
        
        self.textLabel = YYLabel()
        self.textLabel.left = kSeeCellPadding
        self.textLabel.width = kSeeCellContentWidth
        self.textLabel.textVerticalAlignment = .top
        self.textLabel.displaysAsynchronously = true
        self.textLabel.ignoreCommonProperties = true
        self.textLabel.fadeOnHighlight = false
        self.textLabel.fadeOnAsynchronouslyDisplay = false
        self.textLabel.highlightTapAction = { (containerView, text, range,rect) in
            
        }
        self.contentView.addSubview(self.textLabel)
        
        self.retweetTextLabel = YYLabel()
        self.retweetTextLabel.left = kSeeCellPadding
        self.retweetTextLabel.width = kSeeCellContentWidth
        self.retweetTextLabel.textVerticalAlignment = .top
        self.retweetTextLabel.displaysAsynchronously = true
        self.retweetTextLabel.ignoreCommonProperties = true
        self.retweetTextLabel.fadeOnHighlight = false
        self.retweetTextLabel.fadeOnAsynchronouslyDisplay = false
        self.retweetTextLabel.highlightTapAction = { (containerView, text, range,rect) in
            
        }
        self.contentView.addSubview(self.retweetTextLabel)
        
        var tmpPicViews: [UIView] = []
        for index in 0...9 {
            
        }
        
        self.cardView = SeeStatusCardView()
        self.cardView.isHidden = true
        self.contentView.addSubview(self.cardView)
        
        self.tagView = SeeStatusTagView()
        self.tagView.left = kSeeCellPadding
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
        
        self.frame.size.height = layout.height
        self.contentView.top = layout.marginTop
        self.contentView.height = layout.height - layout.marginTop - layout.marginBottom
        
        var top: CGFloat = 0
        if layout.titleHeight > 0 {
            self.titleView.isHidden = false
            self.titleView.height = layout.titleHeight
            top = layout.titleHeight
        } else {
            self.titleView.isHidden = true
        }
        
        self.profileView.avatarView.kf.setImage(with: URL(string: layout.status.user.avatar_large))
        self.profileView.nameLabel.textLayout = layout.nameTextLayout
        self.profileView.sourceLabel.textLayout = layout.sourceTextLayout
        self.profileView.verifyType = layout.status.user.userVerifyType
        self.profileView.height = layout.profileHeight
        self.profileView.top = top
        top += layout.profileHeight
        
    }
}


/// 标题栏
class SeeStatusTitleView: UIView {
    
    var titleLabel: YYLabel!
    var arrowButton: UIButton!
    var tableViewCell: SeeStatusTableViewCell!
    
    override init(frame: CGRect) {
        if frame.width == 0 && frame.height == 0 {
            var tmpFrame = frame
            tmpFrame.size.width = kScreenW
            tmpFrame.size.height = kSeeCellTitleHeight
            super.init(frame: tmpFrame)
        } else {
            super.init(frame: frame)
        }
        
        self.titleLabel = YYLabel()
        self.titleLabel.size = CGSize(width: kScreenW - 100, height: self.height)
        self.titleLabel.left = kSeeCellPadding
        self.titleLabel.displaysAsynchronously = true
        self.titleLabel.ignoreCommonProperties = true
        self.titleLabel.fadeOnHighlight = false
        self.titleLabel.fadeOnAsynchronouslyDisplay = false
        self.addSubview(self.titleLabel)
        
        let line = CALayer()
        line.size = CGSize(width: self.width, height: CGFloatFromPixel(1))
        line.bottom = self.height
        line.backgroundColor = kSeeCellLineColor.cgColor
        self.layer.addSublayer(line)
        
        self.isExclusiveTouch = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/// 用户资料
class SeeStatusProfileView: UIView {
    
    /// 头像
    var avatarView: UIImageView!
    /// 徽章
    var avatarBadgeView: UIImageView!
    /// 名字
    var nameLabel: YYLabel!
    /// 来源
    var sourceLabel: YYLabel!
    var backgroundImageView: UIImageView!
    var arrowButton: UIButton!
    var followButton: UIButton!
    var verifyType = SeeUserVerifyType.none
    var tableViewCell: SeeStatusTableViewCell!
    var trackingTouch = false
    
    override init(frame: CGRect) {
        if frame.width == 0 && frame.height == 0 {
            var tmpFrame = frame
            tmpFrame.size.width = kScreenW
            tmpFrame.size.height = kSeeCellProfileHeight
            super.init(frame: tmpFrame)
        } else {
            super.init(frame: frame)
        }
        
        self.avatarView = UIImageView()
        self.avatarView.size = CGSize(width: 40, height: 40)
        self.avatarView.origin = CGPoint(x: kSeeCellPadding, y: kSeeCellPadding + 3)
        self.avatarView.contentMode = .scaleAspectFill
        self.avatarView.layer.cornerRadius = self.avatarView.height / 2
        self.avatarView.clipsToBounds = true
        self.avatarView.layer.masksToBounds = true
        self.addSubview(self.avatarView)
        
        let avatarBorder = CALayer()
        avatarBorder.frame = self.avatarView.bounds
        avatarBorder.borderWidth = CGFloatFromPixel(1)
        avatarBorder.borderColor = UIColor(white: 0.000, alpha: 0.090).cgColor
        avatarBorder.cornerRadius = self.avatarView.height / 2
        avatarBorder.shouldRasterize = true
        avatarBorder.rasterizationScale = kScreenScale
        avatarBorder.masksToBounds = true
        self.avatarView.layer.addSublayer(avatarBorder)
        
        self.avatarBadgeView = UIImageView()
        self.avatarBadgeView.size = CGSize(width: 14, height: 14)
        self.avatarBadgeView.center = CGPoint(x: self.avatarView.right - 6, y: self.avatarView.bottom - 6)
        self.avatarBadgeView.contentMode = .scaleAspectFit
        self.addSubview(self.avatarBadgeView)
        
        self.nameLabel = YYLabel()
        self.nameLabel.size = CGSize(width: kSeeCellNameWidth, height: 24)
        self.nameLabel.left = self.avatarView.right + kSeeCellNamePaddingLeft
        self.nameLabel.centerY = 27
        self.nameLabel.displaysAsynchronously = true
        self.nameLabel.ignoreCommonProperties = true
        self.nameLabel.fadeOnAsynchronouslyDisplay = false
        self.nameLabel.fadeOnHighlight = false
        self.nameLabel.lineBreakMode = .byClipping
        self.nameLabel.textVerticalAlignment = .center
        self.addSubview(self.nameLabel)
        
        self.sourceLabel = YYLabel()
        self.sourceLabel.frame = self.nameLabel.frame
        self.sourceLabel.centerY = 47
        self.sourceLabel.displaysAsynchronously = true
        self.sourceLabel.ignoreCommonProperties = true
        self.sourceLabel.fadeOnAsynchronouslyDisplay = false
        self.sourceLabel.fadeOnHighlight = false
        self.sourceLabel.highlightTapAction = { (containerView, text, range,rect) in
            
        }
        self.addSubview(self.sourceLabel)
        
        self.isExclusiveTouch = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

/// 卡片
class SeeStatusCardView: UIView {
    
    override init(frame: CGRect) {
        if frame.width == 0 && frame.height == 0 {
            var tmpFrame = frame
            tmpFrame.size.width = kScreenW
            tmpFrame.origin.x = kSeeCellPadding
            super.init(frame: tmpFrame)
        } else {
            super.init(frame: frame)
        }
        
        self.backgroundColor = kSeeCellInnerViewColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/// 下方Tag
class SeeStatusTagView: UIView {
    
    
}

/// 工具栏
class SeeStatusToolbarView: UIView {
    
    
}
