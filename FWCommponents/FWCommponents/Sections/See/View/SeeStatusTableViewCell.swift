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
        
        self.backgroundColor = UIColor.clear
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
    var picViews: [UIImageView] = []
    
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
        
        var tmpPicViews: [UIImageView] = []
        for _ in 0...9 {
            let imageView = UIImageView()
            imageView.size = CGSize(width: 100, height: 100)
            imageView.isHidden = true
            imageView.clipsToBounds = true
            imageView.backgroundColor = kSeeCellHighlightColor
            imageView.isExclusiveTouch = true
            
            let badge = UIView()
            badge.isUserInteractionEnabled = false
            badge.contentMode = .scaleAspectFit
            badge.size = CGSize(width: 56 / 2, height: 36 / 2)
            badge.autoresizingMask = [.flexibleTopMargin, .flexibleLeftMargin]
            badge.right = imageView.width
            badge.bottom = imageView.height
            badge.isHidden = true
            imageView.addSubview(badge)
            
            tmpPicViews.append(imageView)
            self.contentView.addSubview(imageView)
        }
        self.picViews = tmpPicViews
        
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
        
        self.vipBackgroundView.kf.setImage(with: SeeManager.defaultURL(forImageURL: layout.status.pic_bg), placeholder: nil, options: nil, progressBlock: nil) { [weak self] (image, error, type, url) in
            if image != nil {
                let image2 = UIImage.init(cgImage: image!.cgImage!, scale: 2.0, orientation: image!.imageOrientation)
                self?.vipBackgroundView.image = image2
            }
        }
        
        self.textLabel.top = top
        self.textLabel.height = layout.textHeight
        self.textLabel.textLayout = layout.textLayout
        top += layout.textHeight
        
        self.retweetBackgroundView.isHidden = true
        self.retweetTextLabel.isHidden = true
        self.cardView.isHidden = true
        if layout.picHeight == 0 && layout.retweetPicHeight == 0 {
            self.hideImageViews()
        }
        
        // 优先级是 转发->图片->卡片
        if layout.retweetHeight > 0 {
            self.retweetBackgroundView.top = top
            self.retweetBackgroundView.height = layout.retweetHeight
            self.retweetBackgroundView.isHidden = false
            
            self.retweetTextLabel.top = top
            self.retweetTextLabel.height = layout.retweetTextHeight
            self.retweetTextLabel.textLayout = layout.retweetTextLayout
            self.retweetTextLabel.isHidden = false
            
            if layout.retweetPicHeight > 0 {
                self.setImageView(imageTop: self.retweetTextLabel.bottom, isRetweet: true)
            } else {
                self.hideImageViews()
                if layout.retweetCardHeight > 0 {
                    self.cardView.top = self.retweetTextLabel.bottom
                    self.cardView.isHidden = false
                    self.cardView.setWithLayout(layout: layout, isRetweet: true)
                }
            }
        } else if layout.picHeight > 0 {
            self.setImageView(imageTop: top, isRetweet: false)
        } else if layout.cardHeight > 0 {
            self.cardView.top = top
            self.cardView.isHidden = false
            self.cardView.setWithLayout(layout: layout, isRetweet: false)
        }
        
        if layout.tagHeight > 0 {
            self.tagView.isHidden = false
            self.tagView.setupLayout(layout: layout)
            self.tagView.centerY = self.contentView.height - kSeeCellToolbarHeight - layout.tagHeight / 2
        } else {
            self.tagView.isHidden = true
        }
        
        self.toolbarView.bottom = self.contentView.height
        self.toolbarView.setupLayout(layout: layout)
    }
    
    func hideImageViews() {
        for imageView in self.picViews {
            imageView.isHidden = true
        }
    }
    
    func setImageView(imageTop: CGFloat, isRetweet: Bool) {
        
        let picSize = isRetweet ? self.layout.retweetPicSize : self.layout.picSize
        let pics = isRetweet ? self.layout.status.retweeted_status!.pics : self.layout.status.pics
        
        let picsCount = pics.count
        
        if picSize == nil {
            return
        }
        
        for index in 0...8 {
            let imageView = self.picViews[index]
            if index >= pics.count {
                imageView.layer.cancelCurrentImageRequest()
                imageView.isHidden = true
            } else {
                var origin = CGPoint(x: 0, y: 0)
                switch picsCount {
                case 1:
                    origin.x = kSeeCellPadding
                    origin.y = imageTop
                    break
                case 4:
                    origin.x = kSeeCellPadding + CGFloat(index % 2) * (picSize!.width + CGFloat(kSeeCellPaddingPic))
                    origin.y = imageTop + CGFloat(index / 2) * (picSize!.height + CGFloat(kSeeCellPaddingPic))
                    break
                default:
                    origin.x = kSeeCellPadding + CGFloat(index % 3) * (picSize!.width + CGFloat(kSeeCellPaddingPic))
                    origin.y = imageTop + CGFloat(index / 3) * (picSize!.height + CGFloat(kSeeCellPaddingPic))
                    break
                }
                
                imageView.frame = CGRect(x: origin.x, y: origin.y, width: picSize!.width, height: picSize!.height)
                imageView.isHidden = false
                imageView.layer.removeAnimation(forKey: "contents")
                
                let pic = pics[index]
                
                let badge = imageView.subviews.first
                switch pic.largest.badgeType {
                    
                case .none:
                    if badge?.layer.contents != nil {
                        badge?.layer.contents = nil
                        badge?.isHidden = true
                    }
                case .long:
                    badge?.layer.contents = SeeManager.imageNamed("timeline_image_longimage").cgImage
                    badge?.isHidden = false
                case .gif:
                    badge?.layer.contents = SeeManager.imageNamed("timeline_image_gif").cgImage
                    badge?.isHidden = false
                }
                
                imageView.kf.setImage(with: SeeManager.defaultURL(forImageURL: pic.bmiddle.url) as URL, placeholder: nil, options: nil, progressBlock: nil) { (image, error, type, url) in
                    
                }
            }
        }
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
    
    public func setupLayout(layout: SeeStatusLayout) {
        
    }
    
    public func setWithLayout(layout: SeeStatusLayout, isRetweet: Bool) {
        
    }
}

/// 下方Tag
class SeeStatusTagView: UIView {
    
    public func setupLayout(layout: SeeStatusLayout) {
        
    }
}

/// 工具栏
class SeeStatusToolbarView: UIView {
    
    var repostButton: UIButton!
    var commentButton: UIButton!
    var likeButton: UIButton!
    
    var repostImageView: UIImageView!
    var commentImageView: UIImageView!
    var likeImageView: UIImageView!
    
    var repostLabel: YYLabel!
    var commentLabel: YYLabel!
    var likeLabel: YYLabel!
    
    var line1: CAGradientLayer!
    var line2: CAGradientLayer!
    var topLine: CALayer!
    var bottomLine: CALayer!
    
    var tableViewCell: SeeStatusTableViewCell!
    
    override init(frame: CGRect) {
        if frame.width == 0 && frame.height == 0 {
            var tmpFrame = frame
            tmpFrame.size.width = kScreenW
            tmpFrame.size.height = kSeeCellToolbarHeight
            super.init(frame: tmpFrame)
        } else {
            super.init(frame: frame)
        }
        
        self.isExclusiveTouch = true
        
        self.repostButton = UIButton(type: .custom)
        self.repostButton.isExclusiveTouch = true
        self.repostButton.size = CGSize(width: CGFloatPixelRound(self.width / 3.0), height: self.height)
        self.repostButton.setBackgroundImage(UIImage(color: kSeeCellHighlightColor), for: .highlighted)
        
        self.commentButton = UIButton(type: .custom)
        self.commentButton.isExclusiveTouch = true
        self.commentButton.size = CGSize(width: CGFloatPixelRound(self.width / 3.0), height: self.height)
        self.commentButton.left = CGFloatPixelRound(self.width / 3.0)
        self.commentButton.setBackgroundImage(UIImage(color: kSeeCellHighlightColor), for: .highlighted)
        
        self.likeButton = UIButton(type: .custom)
        self.likeButton.isExclusiveTouch = true
        self.likeButton.size = CGSize(width: CGFloatPixelRound(self.width / 3.0), height: self.height)
        self.likeButton.left = CGFloatPixelRound(self.width / 3.0 * 2.0)
        self.likeButton.setBackgroundImage(UIImage(color: kSeeCellHighlightColor), for: .highlighted)
        
        self.repostImageView = UIImageView(image: SeeManager.imageNamed("timeline_icon_retweet"))
        self.repostImageView.centerY = self.height / 2
        self.repostButton.addSubview(self.repostImageView)
        
        self.commentImageView = UIImageView(image: SeeManager.imageNamed("timeline_icon_comment"))
        self.commentImageView.centerY = self.height / 2
        self.commentButton.addSubview(self.commentImageView)
        
        self.likeImageView = UIImageView(image: SeeManager.imageNamed("timeline_icon_unlike"))
        self.likeImageView.centerY = self.height / 2
        self.likeButton.addSubview(self.likeImageView)
        
        self.repostLabel = YYLabel()
        self.repostLabel.isUserInteractionEnabled = false
        self.repostLabel.height = self.height
        self.repostLabel.textVerticalAlignment = YYTextVerticalAlignment.center
        self.repostLabel.displaysAsynchronously = true
        self.repostLabel.ignoreCommonProperties = true
        self.repostLabel.fadeOnHighlight = false
        self.repostLabel.fadeOnAsynchronouslyDisplay = false
        self.repostButton.addSubview(self.repostLabel)
        
        self.commentLabel = YYLabel()
        self.commentLabel.isUserInteractionEnabled = false
        self.commentLabel.height = self.height
        self.commentLabel.textVerticalAlignment = YYTextVerticalAlignment.center
        self.commentLabel.displaysAsynchronously = true
        self.commentLabel.ignoreCommonProperties = true
        self.commentLabel.fadeOnHighlight = false
        self.commentLabel.fadeOnAsynchronouslyDisplay = false
        self.commentButton.addSubview(self.commentLabel)
        
        self.likeLabel = YYLabel()
        self.likeLabel.isUserInteractionEnabled = false
        self.likeLabel.height = self.height
        self.likeLabel.textVerticalAlignment = YYTextVerticalAlignment.center
        self.likeLabel.displaysAsynchronously = true
        self.likeLabel.ignoreCommonProperties = true
        self.likeLabel.fadeOnHighlight = false
        self.likeLabel.fadeOnAsynchronouslyDisplay = false
        self.likeButton.addSubview(self.likeLabel)
        
        let dark = UIColor(white: 0, alpha: 0.2)
        let clear = UIColor(white: 0, alpha: 0)
        let colors = [clear.cgColor, dark.cgColor, clear.cgColor]
        let locations = [NSNumber(value: 0.2), NSNumber(value: 0.5), NSNumber(value: 0.8)]
        
        self.line1 = CAGradientLayer()
        self.line1.colors = colors
        self.line1.locations = locations
        self.line1.startPoint = CGPoint(x: 0, y: 0)
        self.line1.endPoint = CGPoint(x: 0, y: 1)
        self.line1.size = CGSize(width: CGFloatFromPixel(1), height: self.height)
        self.line1.left = self.repostButton.right
        
        self.line2 = CAGradientLayer()
        self.line2.colors = colors
        self.line2.locations = locations
        self.line2.startPoint = CGPoint(x: 0, y: 0)
        self.line2.endPoint = CGPoint(x: 0, y: 1)
        self.line2.size = CGSize(width: CGFloatFromPixel(1), height: self.height)
        self.line2.left = self.commentButton.right
        
        self.topLine = CALayer()
        self.topLine.size = CGSize(width: self.width, height: CGFloatFromPixel(1))
        self.topLine.backgroundColor = kSeeCellLineColor.cgColor
        
        self.bottomLine = CALayer()
        self.bottomLine.size = self.topLine.size
        self.bottomLine.bottom = self.height
        self.bottomLine.backgroundColor = UIColorHex(hexString: "e8e8e8").cgColor
        
        self.addSubview(self.repostButton)
        self.addSubview(self.commentButton)
        self.addSubview(self.likeButton)
        self.layer.addSublayer(self.line1)
        self.layer.addSublayer(self.line2)
        self.layer.addSublayer(self.topLine)
        self.layer.addSublayer(self.bottomLine)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupLayout(layout: SeeStatusLayout) {
        
        self.repostLabel.width = layout.toolbarRepostTextWidth
        self.commentLabel.width = layout.toolbarCommentTextWidth
        self.likeLabel.width = layout.toolbarLikeTextWidth
        
        self.repostLabel.textLayout = layout.toolbarRepostTextLayout
        self.commentLabel.textLayout = layout.toolbarCommentTextLayout
        self.likeLabel.textLayout = layout.toolbarLikeTextLayout
        
        self.adjust(image: self.repostImageView, label: self.repostLabel, button: self.repostButton)
        self.adjust(image: self.commentImageView, label: self.commentLabel, button: self.commentButton)
        self.adjust(image: self.likeImageView, label: self.likeLabel, button: self.likeButton)
        
        self.likeImageView.image = layout.status.attitudes_status > 0 ? SeeManager.imageNamed("timeline_icon_like") : SeeManager.imageNamed("timeline_icon_unlike")
    }
    
    func adjust(image: UIImageView, label: YYLabel, button: UIButton) {
        
        let imageWidth = image.bounds.size.width
        let labelWidth = label.width
        let paddingMid: CGFloat = 5
        let paddingSide = (button.width - imageWidth - labelWidth - paddingMid) / 2.0
        image.centerX = CGFloatPixelRound(paddingSide + imageWidth / 2)
        label.right = CGFloatPixelRound(button.width - paddingSide)
    }
}
