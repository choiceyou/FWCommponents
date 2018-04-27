//
//  SeeStatusLayout.swift
//  FWCommponents
//
//  Created by xfg on 2018/4/27.
//  Copyright © 2018年 xfg. All rights reserved.
//

import Foundation
import UIKit
import YYKit

// 宽高
let kSeeCellTopMargin = 8      // cell 顶部灰色留白
let kSeeCellTitleHeight = 36   // cell 标题高度 (例如"仅自己可见")
let kSeeCellPadding = 12       // cell 内边距
let kSeeCellPaddingText = 10   // cell 文本与其他元素间留白
let kSeeCellPaddingPic = 4     // cell 多张图片中间留白
let kSeeCellProfileHeight = 56 // cell 名片高度
let kSeeCellCardHeight = 70    // cell card 视图高度
let kSeeCellNamePaddingLeft = 14 // cell 名字和 avatar 之间留白
let kSeeCellContentWidth = (kScreenW - CGFloat(2 * kSeeCellPadding)) // cell 内容宽度
let kSeeCellNameWidth = (kScreenW - 110) // cell 名字最宽限制

let kSeeCellTagPadding = 8         // tag 上下留白
let kSeeCellTagNormalHeight = 16   // 一般 tag 高度
let kSeeCellTagPlaceHeight = 24    // 地理位置 tag 高度

let kSeeCellToolbarHeight = 35     // cell 下方工具栏高度
let kSeeCellToolbarBottomMargin = 2 // cell 下方灰色留白

// 字体 应该做成动态的，这里只是 Demo，临时写死了。
let kSeeCellNameFontSize = 16      // 名字字体大小
let kSeeCellSourceFontSize = 12    // 来源字体大小
let kSeeCellTextFontSize = 17      // 文本字体大小
let kSeeCellTextFontRetweetSize = 16 // 转发字体大小
let kSeeCellCardTitleFontSize = 16 // 卡片标题文本字体大小
let kSeeCellCardDescFontSize = 12 // 卡片描述文本字体大小
let kSeeCellTitlebarFontSize = 14 // 标题栏字体大小
let kSeeCellToolbarFontSize = 14 // 工具栏字体大小

// 颜色
let kSeeCellNameNormalColor = UIColorHex(hexString: "333333") // 名字颜色
let kSeeCellNameOrangeColor = UIColorHex(hexString: "f26220") // 橙名颜色 (VIP)
let kSeeCellTimeNormalColor = UIColorHex(hexString: "828282") // 时间颜色
let kSeeCellTimeOrangeColor = UIColorHex(hexString: "f28824") // 橙色时间 (最新刷出)

let kSeeCellTextNormalColor = UIColorHex(hexString: "333333") // 一般文本色
let kSeeCellTextSubTitleColor = UIColorHex(hexString: "5d5d5d") // 次要文本色
let kSeeCellTextHighlightColor = UIColorHex(hexString: "527ead") // Link 文本色
let kSeeCellTextHighlightBackgroundColor = UIColorHex(hexString: "bfdffe") // Link 点击背景色
let kSeeCellToolbarTitleColor = UIColorHex(hexString: "929292") // 工具栏文本色
let kSeeCellToolbarTitleHighlightColor = UIColorHex(hexString: "df422d") // 工具栏文本高亮色

let kSeeCellBackgroundColor = UIColorHex(hexString: "f2f2f2")    // Cell背景灰色
let kSeeCellHighlightColor = UIColorHex(hexString: "f0f0f0")     // Cell高亮时灰色
let kSeeCellInnerViewColor = UIColorHex(hexString: "f7f7f7")   // Cell内部卡片灰色
let kSeeCellInnerViewHighlightColor =  UIColorHex(hexString: "f0f0f0") // Cell内部卡片高亮时灰色
let kSeeCellLineColor = UIColor(white: 0.000, alpha: 0.09) //线条颜色

let kSeeLinkHrefName = "href" //NSString
let kSeeLinkURLName = "url" //WBURL
let kSeeLinkTagName = "tag" //WBTag
let kSeeLinkTopicName = "topic" //WBTopic
let kSeeLinkAtName = "at" //NSString

/// 风格
///
/// - Timeline: 时间线 (目前只支持这一种)
/// - detail: 详情页
enum SeeLayoutStyle: Int {
    case Timeline
    case detail
}

/// 卡片类型 (这里随便写的，只适配了微博中常见的类型)
///
/// - none: 没卡片
/// - normal: 一般卡片布局
/// - video: 视频
enum SeeStatusCardType: Int {
    case none
    case normal
    case video
}

/// 最下方Tag类型，也是随便写的，微博可能有更多类型同时存在等情况
///
/// - none: 没Tag
/// - normal: 文本
/// - place: 地点
enum SeeStatusTagType: Int {
    case none
    case normal
    case place
}

/**
 一个 Cell 的布局。
 布局排版应该在后台线程完成。
 */
class SeeStatusLayout: NSObject {
    
    
    // ==以下是数据==
    var status: SeeStatusModel!
    var style: SeeLayoutStyle!
    
    // ==以下是布局结果==
    
    /// 顶部灰色留白
    var marginTop: CGFloat = 0.0
    
    // ==标题栏==
    /// 标题栏高度，0为没标题栏
    var titleHeight: CGFloat = 0.0
    /// 标题栏
    var titleTextLayout: YYTextLayout!
    
    // ==个人资料==
    /// 个人资料高度(包括留白)
    var profileHeight: CGFloat = 0.0
    /// 名字
    var nameTextLayout: YYTextLayout!
    /// 时间/来源
    var sourceTextLayout: YYTextLayout!
    
    // ==文本==
    /// 文本高度(包括下方留白)
    var textHeight: CGFloat = 0.0
    /// 文本
    var textLayout: YYTextLayout!
    
    // ==图片==
    /// 图片高度，0为没图片
    var picHeight: CGFloat = 0.0
    var picSize: CGSize!
    
    // ==转发==
    /// 转发高度，0为没转发
    var retweetHeight: CGFloat = 0.0
    var retweetTextHeight: CGFloat = 0.0
    /// 被转发文本
    var retweetTextLayout: YYTextLayout!
    var retweetPicHeight: CGFloat = 0.0
    var retweetPicSize: CGSize!
    var retweetCardHeight: CGFloat = 0.0
    var retweetCardType: SeeStatusCardType!
    /// 被转发文本
    var retweetCardTextLayout: YYTextLayout!
    var retweetCardTextRect: CGRect!
    
    // ==卡片==
    /// 卡片高度，0为没卡片
    var cardHeight: CGFloat = 0.0
    var cardType: SeeStatusCardType!
    /// 卡片文本
    var cardTextLayout: YYTextLayout!
    var cardTextRect: CGRect!
    
    // ==Tag==
    /// Tip高度，0为没tip
    var tagHeight: CGFloat = 0.0
    var tagType: SeeStatusTagType!
    /// 最下方tag
    var tagTextLayout: YYTextLayout!
    
    // ==工具栏==
    /// 工具栏
    var toolbarHeight: CGFloat = 0.0
    var toolbarRepostTextLayout: YYTextLayout!
    var toolbarCommentTextLayout: YYTextLayout!
    var toolbarLikeTextLayout: YYTextLayout!
    var toolbarRepostTextWidth: CGFloat = 0.0
    var toolbarCommentTextWidth: CGFloat = 0.0
    var toolbarLikeTextWidth: CGFloat = 0.0
    
    /// 下边留白
    var marginBottom: CGFloat = 0.0
    
    /// 总高度
    var height: CGFloat = 0.0
    
    
    init(status: SeeStatusModel, style: SeeLayoutStyle) {
        super.init()
        
    }
    
    /// 计算布局
    func layout() {
        
    }
    
    /// 更新时间字符串
    func updateDate() {
        
    }
}

class SeeTextLinePositionModifier: NSObject, YYTextLinePositionModifier {
    
    /// 基准字体 (例如 Heiti SC/PingFang SC)
    var font: UIFont!
    /// 文本顶部留白
    var paddingTop: CGFloat = 0.0
    /// 文本底部留白
    var paddingBottom: CGFloat = 0.0
    /// 行距倍数
    var lineHeightMultiple: CGFloat = 0.0
    
    override init() {
        super.init()
        
        if #available(iOS 9.0, *) {
            self.lineHeightMultiple = 1.34
        } else {
            self.lineHeightMultiple = 1.3125
        }
    }
    
    func heightForLineCount(lineCount: Int) -> CGFloat {
        if lineCount == 0 {
            return 0
        }
        let ascent = self.font.pointSize * 0.86
        let descent = self.font.pointSize * 0.14
        let lineHeight = self.font.pointSize * self.lineHeightMultiple
        return self.paddingTop + self.paddingBottom + ascent + descent + CGFloat(lineCount - 1) * lineHeight
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        
        let one = SeeTextLinePositionModifier.self()
        one.font = self.font
        one.paddingTop = self.paddingTop
        one.paddingBottom = self.paddingBottom
        one.lineHeightMultiple = self.lineHeightMultiple
        return one
    }
    
    func modifyLines(_ lines: [YYTextLine], fromText text: NSAttributedString, in container: YYTextContainer) {
        let ascent = self.font.pointSize * 0.86
        
        let lineHeight = self.font.pointSize * self.lineHeightMultiple
        for line: YYTextLine in lines {
            var position = line.position
            position.y = self.paddingTop + ascent + CGFloat(line.row) * lineHeight
            line.position = position
        }
    }
}

/// 微博的文本中，某些嵌入的图片需要从网上下载，这里简单做个封装
class SeeTextImageViewAttachment: YYTextAttachment {
    
    var imageURL: URL!
    var size: CGSize!
    var imageView: UIImageView?
    
    func setContent(content: Any) {
        self.imageView = content as? UIImageView
    }
    
    func content() -> Any? {
        
        if pthread_main_np() == 0 {
            return nil
        }
        if self.imageView != nil {
            return self.imageView
        }
        
        self.imageView = UIImageView()
        self.imageView?.size = self.size
        self.imageView?.setImageWith(self.imageURL, placeholder: nil)
        return self.imageView
    }
}
