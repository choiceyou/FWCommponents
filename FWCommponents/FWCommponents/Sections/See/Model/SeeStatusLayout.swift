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
let kSeeCellTopMargin: CGFloat = 8      // cell 顶部灰色留白
let kSeeCellTitleHeight: CGFloat = 36   // cell 标题高度 (例如"仅自己可见")
let kSeeCellPadding: CGFloat = 12       // cell 内边距
let kSeeCellPaddingText: CGFloat = 10   // cell 文本与其他元素间留白
let kSeeCellPaddingPic: CGFloat = 4     // cell 多张图片中间留白
let kSeeCellProfileHeight: CGFloat = 56 // cell 名片高度
let kSeeCellCardHeight: CGFloat = 70    // cell card 视图高度
let kSeeCellNamePaddingLeft: CGFloat = 14 // cell 名字和 avatar 之间留白
let kSeeCellContentWidth: CGFloat = (kScreenW - CGFloat(2 * kSeeCellPadding)) // cell 内容宽度
let kSeeCellNameWidth: CGFloat = (kScreenW - 110) // cell 名字最宽限制

let kSeeCellTagPadding: CGFloat = 8         // tag 上下留白
let kSeeCellTagNormalHeight: CGFloat = 16   // 一般 tag 高度
let kSeeCellTagPlaceHeight: CGFloat = 24    // 地理位置 tag 高度

let kSeeCellToolbarHeight: CGFloat = 35     // cell 下方工具栏高度
let kSeeCellToolbarBottomMargin: CGFloat = 2 // cell 下方灰色留白

// 字体 应该做成动态的，这里只是 Demo，临时写死了。
let kSeeCellNameFontSize: CGFloat = 16      // 名字字体大小
let kSeeCellSourceFontSize: CGFloat = 12    // 来源字体大小
let kSeeCellTextFontSize: CGFloat = 17      // 文本字体大小
let kSeeCellTextFontRetweetSize: CGFloat = 16 // 转发字体大小
let kSeeCellCardTitleFontSize: CGFloat = 16 // 卡片标题文本字体大小
let kSeeCellCardDescFontSize: CGFloat = 12 // 卡片描述文本字体大小
let kSeeCellTitlebarFontSize: CGFloat = 14 // 标题栏字体大小
let kSeeCellToolbarFontSize: CGFloat = 14 // 工具栏字体大小

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
    var marginTop: CGFloat = kSeeCellTopMargin
    
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
    var tagType = SeeStatusTagType.none
    /// 最下方tag
    var tagTextLayout: YYTextLayout!
    
    // ==工具栏==
    /// 工具栏
    var toolbarHeight: CGFloat = kSeeCellToolbarHeight
    var toolbarRepostTextLayout: YYTextLayout!
    var toolbarCommentTextLayout: YYTextLayout!
    var toolbarLikeTextLayout: YYTextLayout!
    var toolbarRepostTextWidth: CGFloat = 0.0
    var toolbarCommentTextWidth: CGFloat = 0.0
    var toolbarLikeTextWidth: CGFloat = 0.0
    
    /// 下边留白
    var marginBottom: CGFloat = kSeeCellToolbarBottomMargin
    
    /// 总高度
    var height: CGFloat = 0.0
    
    
    init(status: SeeStatusModel, style: SeeLayoutStyle) {
        super.init()
        
        self.status = status
        self.style = style
        
        self.layout()
    }
    
    /// 计算布局
    func layout() {
        
        // 文本排版，计算布局
        self.layoutTitle()
        self.layoutProfile()
        if self.status.retweeted_status != nil {
            self.layoutRetweet()
        }
        if self.retweetHeight == 0 {
            self.layoutPics()
            if self.picHeight == 0 {
                self.layoutCard()
            }
        }
        self.layoutText()
        self.layoutTag()
        self.layoutToolbar()
        
        // 计算高度
        self.height += self.marginTop
        self.height += self.titleHeight
        self.height += self.profileHeight
        self.height += self.textHeight
        if self.retweetHeight > 0 {
            self.height += self.retweetHeight
        } else if (self.picHeight > 0) {
            self.height += self.picHeight
        } else if (self.cardHeight > 0) {
            self.height += self.cardHeight
        }
        if self.tagHeight > 0 {
            self.height += self.tagHeight
        } else {
            if self.picHeight > 0 || self.cardHeight > 0 {
                self.height += kSeeCellPadding
            }
        }
        self.height += self.toolbarHeight
        self.height += self.marginBottom
    }
    
    /// 更新时间字符串
    func updateDate() {
        
    }
    
    func layoutTitle() {
        
        self.titleHeight = 0
        self.titleTextLayout = nil
        
        let title = self.status.title
        if title.text.count == 0 {
            return
        }
        
        let text = NSMutableAttributedString(string: title.text)
        if !title.iconURL.isEmpty {
            let icon = self.attachment(fontSize: kSeeCellTitlebarFontSize, imageURL: title.iconURL, shrink: false)
            if icon.length > 0 {
                text.insert(icon, at: 0)
            }
        }
        text.color = kSeeCellToolbarTitleColor
        text.font = UIFont.systemFont(ofSize: kSeeCellTitlebarFontSize)
        
        let container = YYTextContainer(size: CGSize(width: kScreenW - 100, height: kSeeCellTitleHeight))
        self.titleTextLayout = YYTextLayout(container: container, text: text)
        self.titleHeight = kSeeCellTitleHeight
    }
    
    func attachment(fontSize: CGFloat, imageURL: String, shrink: Bool) -> NSMutableAttributedString {
        
        /**
         微博 URL 嵌入的图片，比临近的字体要小一圈。。
         这里模拟一下 Heiti SC 字体，然后把图片缩小一下。
         */
        let ascent = fontSize * 0.86
        let descent = fontSize * 0.14
        let bounding = CGRect(x: 0, y: -0.14 * fontSize, width: fontSize, height: fontSize)
        var contentInsets = UIEdgeInsetsMake(ascent - (bounding.size.height + bounding.origin.y), 0, descent + bounding.origin.y, 0)
        var size = CGSize(width: fontSize, height: fontSize)
        
        if shrink {
            // 缩小
            let scale = CGFloat(1 / 10.0)
            contentInsets.top += fontSize * scale
            contentInsets.bottom += fontSize * scale
            contentInsets.left += fontSize * scale
            contentInsets.right += fontSize * scale
            contentInsets = UIEdgeInsetPixelFloor(contentInsets)
            size = CGSize(width: fontSize - fontSize * scale * 2, height: fontSize - fontSize * scale * 2)
            size = CGSizePixelRound(size)
        }
        
        let delegate = YYTextRunDelegate()
        delegate.ascent = ascent
        delegate.descent = descent
        delegate.width = bounding.size.width
        
        let attachment = SeeTextImageViewAttachment()
        attachment.contentMode = .scaleAspectFit
        attachment.contentInsets = contentInsets
        attachment.size = size
        attachment.imageURL = URL(string: imageURL)
        
        let atr = NSMutableAttributedString(string: YYTextAttachmentToken)
        atr.setTextAttachment(attachment, range: NSMakeRange(0, atr.length))
        let ctDelegate = delegate.ctRunDelegate()
        atr.setRunDelegate(ctDelegate, range: NSMakeRange(0, atr.length))
        return atr
    }
    
    func attachment(fontSize: CGFloat, image: UIImage, shrink: Bool) -> NSMutableAttributedString {
        
        // Heiti SC 字体。。
        let ascent = fontSize * 0.86
        let descent = fontSize * 0.14
        let bounding = CGRect(x: 0, y: -0.14 * fontSize, width: fontSize, height: fontSize)
        var contentInsets = UIEdgeInsetsMake(ascent - (bounding.size.height + bounding.origin.y), 0, descent + bounding.origin.y, 0)
        var size = CGSize(width: fontSize, height: fontSize)
        
        if shrink {
            // 缩小
            let scale = CGFloat(1 / 10.0)
            contentInsets.top += fontSize * scale
            contentInsets.bottom += fontSize * scale
            contentInsets.left += fontSize * scale
            contentInsets.right += fontSize * scale
            contentInsets = UIEdgeInsetPixelFloor(contentInsets)
            size = CGSize(width: fontSize - fontSize * scale * 2, height: fontSize - fontSize * scale * 2)
            size = CGSizePixelRound(size)
        }
        
        let delegate = YYTextRunDelegate()
        delegate.ascent = ascent
        delegate.descent = descent
        delegate.width = bounding.size.width
        
        let attachment = SeeTextImageViewAttachment()
        attachment.contentMode = .scaleAspectFit
        attachment.contentInsets = contentInsets
        attachment.content = image
        
        let atr = NSMutableAttributedString(string: YYTextAttachmentToken)
        atr.setTextAttachment(attachment, range: NSMakeRange(0, atr.length))
        let ctDelegate = delegate.ctRunDelegate()
        atr.setRunDelegate(ctDelegate, range: NSMakeRange(0, atr.length))
        return atr
    }
    
    func layoutProfile() {
        
        self.layoutName()
        self.layoutSource()
        
        self.profileHeight = kSeeCellProfileHeight
    }
    
    /// 转发
    func layoutRetweet() {
        
        self.retweetHeight = 0
        self.layoutRetweetedText()
        self.layoutRetweetPics()
        if self.retweetPicHeight == 0 {
            self.layoutRetweetCard()
        }
        
        self.retweetHeight = self.retweetTextHeight
        if self.retweetPicHeight > 0 {
            self.retweetHeight += self.retweetPicHeight
            self.retweetHeight += kSeeCellPadding
        } else if self.retweetCardHeight > 0 {
            self.retweetHeight += self.retweetCardHeight
            self.retweetHeight += kSeeCellPadding
        }
    }
    
    
    /// 文本
    func layoutText() {
        
        self.textHeight = 0
        self.textLayout = nil
        
        let text = self.text(status: self.status, isRetweet: false, fontSize: kSeeCellTextFontSize, textColor: kSeeCellTextNormalColor)
        if text == nil || text!.length == 0 {
            return
        }
        
        let modifier = SeeTextLinePositionModifier()
        modifier.font = UIFont.init(name: "Heiti SC", size: kSeeCellTextFontSize)
        modifier.paddingTop = kSeeCellPaddingText
        modifier.paddingBottom = kSeeCellPaddingText
        
        let container = YYTextContainer()
        container.size = CGSize(width: kSeeCellContentWidth, height: CGFloat(HUGE))
        container.linePositionModifier = modifier
        
        self.textLayout = YYTextLayout(container: container, text: text!)
        if self.textLayout == nil {
            return
        }
        
        self.textHeight = modifier.heightForLineCount(lineCount: Int(self.textLayout.rowCount))
    }
    
    func layoutRetweetedText() {
        
        self.retweetHeight = 0
        self.retweetTextLayout = nil
        
        let text = self.text(status: self.status.retweeted_status!, isRetweet: true, fontSize: kSeeCellTextFontRetweetSize, textColor: kSeeCellTextSubTitleColor)
        
        if text?.length == 0 {
            return
        }
        
        let modifier = SeeTextLinePositionModifier()
        modifier.font = UIFont.init(name: "Heiti SC", size: kSeeCellTextFontRetweetSize)
        modifier.paddingTop = kSeeCellPaddingText
        modifier.paddingBottom = kSeeCellPaddingText
        
        let container = YYTextContainer()
        container.size = CGSize(width: kSeeCellContentWidth, height: CGFloat(HUGE))
        container.linePositionModifier = modifier
        
        self.retweetTextLayout = YYTextLayout(container: container, text: text!)
        if self.retweetTextLayout == nil {
            return
        }
        
        self.retweetTextHeight = modifier.heightForLineCount(lineCount: self.retweetTextLayout.lines.count)
    }
    
    func text(status: SeeStatusModel, isRetweet: Bool, fontSize: CGFloat, textColor: UIColor) -> NSMutableAttributedString? {
        
        var string = status.text
        if string.count == 0 {
            return nil
        }
        
        if isRetweet {
            var name = status.user.name
            if name.isEmpty {
                name = status.user.screen_name
            }
            
            if !name.isEmpty {
                let insert = "@\(name)"
                string = insert + string
            }
        }
        
        // 字体
        let font = UIFont.systemFont(ofSize: fontSize)
        // 高亮状态的背景
        let highlightBorder = YYTextBorder()
        highlightBorder.insets = UIEdgeInsetsMake(-2, 0, -2, 0)
        highlightBorder.cornerRadius = 3
        highlightBorder.fillColor = kSeeCellTextHighlightBackgroundColor
        
        let text = NSMutableAttributedString(string: string as String)
        text.font = font
        text.color = textColor
        
        // 根据 urlStruct 中每个 URL.shortURL 来匹配文本，将其替换为图标+友好描述
        for seeUrl: SeeURLModel in status.url_struct {
            if seeUrl.short_url.count == 0 {
                continue
            }
            if seeUrl.url_title.count == 0 {
                continue
            }
            
            var urlTitle = seeUrl.url_title
            if urlTitle.count > 27 {
                let index = urlTitle.index(urlTitle.startIndex, offsetBy: 27)
                urlTitle = String(urlTitle[..<index])
                urlTitle.append(YYTextTruncationToken)
            }
            
            var searchRange = NSMakeRange(0, text.string.count)
            repeat {
                //                let range = text.string.range(of: seeUrl.short_url, options: [], range: Range.init(searchRange, in: text.string), locale: nil)
                
                let tmpStr = text.string as NSString
                let range: NSRange = tmpStr.range(of: seeUrl.short_url, options: [], range: searchRange, locale: nil)
                
                if range.location == NSNotFound {
                    break
                }
                
                if range.location + range.length == text.length {
                    if !status.page_info.page_id.isEmpty && !seeUrl.page_id.isEmpty && seeUrl.page_id == status.page_info.page_id {
                        if status.pics.count == 0 {
                            text.replaceCharacters(in: range, with: "")
                            break // cut the tail, show with card
                        }
                    }
                }
                
                if (text.attribute(NSAttributedStringKey(rawValue: YYTextHighlightAttributeName), at: range.location, effectiveRange: nil) == nil) {
                    
                    // 替换的内容
                    let replace = NSMutableAttributedString(string: urlTitle)
                    if seeUrl.url_type_pic.count > 0 {
                        // 链接头部有个图片附件 (要从网络获取)
                        let picURL = SeeManager.defaultURL(forImageURL: seeUrl.url_type_pic)
                        if picURL != nil {
                            let image = YYImageCache.shared().getImageForKey(picURL!.absoluteString)
                            let pic = (image != nil && seeUrl.pics.count == 0) ? self.attachment(fontSize: fontSize, image: image!, shrink: true) : self.attachment(fontSize: fontSize, imageURL: seeUrl.url_type_pic, shrink: true)
                            replace.insert(pic, at: 0)
                        }
                    }
                    replace.font = font
                    replace.color = kSeeCellTextHighlightColor
                    
                    // 高亮状态
                    let highlight = YYTextHighlight()
                    highlight.setBackgroundBorder(highlightBorder)
                    // 数据信息，用于稍后用户点击
                    highlight.userInfo = [kSeeLinkURLName : seeUrl]
                    replace.setTextHighlight(highlight, range: NSMakeRange(0, replace.length))
                    
                    // 添加被替换的原始字符串，用于复制
                    let tmpStr = text.string as NSString
                    
                    let backed = YYTextBackedString(string: tmpStr.substring(with: range))
                    replace.setTextBacked(backed, range: NSMakeRange(0, replace.length))
                    
                    // 替换
                    text.replaceCharacters(in: range, with: replace)
                    
                    searchRange.location = searchRange.location + (replace.length > 0 ? replace.length : 1)
                    if searchRange.location + 1 >= text.length {
                        break
                    }
                    searchRange.length = text.length - searchRange.location
                } else {
                    searchRange.location = searchRange.location + (searchRange.length > 0 ? searchRange.length : 1)
                    if searchRange.location + 1 >= text.length {
                        break
                    }
                    searchRange.length = text.length - searchRange.location
                }
                
            } while true
        }
        
        // 根据 topicStruct 中每个 Topic.topicTitle 来匹配文本，标记为话题
        for topic: SeeTopicModel in status.topic_struct {
            
            if topic.topic_title.count == 0 {
                continue
            }
            
            let topicTitle = "#\(topic.topic_title)#"
            var searchRange = NSMakeRange(0, text.string.count)
            repeat {
                let tmpStr = text.string as NSString
                let range = tmpStr.range(of: topicTitle, options: [], range: searchRange)
                if range.location == NSNotFound {
                    break
                }
                
                if text.attribute(NSAttributedStringKey(rawValue: YYTextHighlightAttributeName), at: range.location, effectiveRange: nil) == nil {
                    text.setColor(kSeeCellTextHighlightColor, range: range)
                    
                    // 高亮状态
                    let highlight = YYTextHighlight()
                    highlight.setBackgroundBorder(highlightBorder)
                    // 数据信息，用于稍后用户点击
                    highlight.userInfo = [kSeeLinkTopicName : topic]
                    text.setTextHighlight(highlight, range: range)
                }
                searchRange.location = searchRange.location + (searchRange.length > 0 ? searchRange.length : 1)
                if searchRange.location + 1 >= text.length {
                    break
                }
                searchRange.length = text.length - searchRange.location
                
            } while true
        }
        
        // 匹配 @用户名
        let atResults = SeeManager.regexAt().matches(in: text.string, options: [], range: text.rangeOfAll())
        for at: NSTextCheckingResult in atResults {
            if at.range.location == NSNotFound && at.range.length <= 1 {
                continue
            }
            if text.attribute(NSAttributedStringKey(rawValue: YYTextHighlightAttributeName), at: at.range.location, effectiveRange: nil) == nil {
                text.setColor(kSeeCellTextHighlightColor, range: at.range)
                
                // 高亮状态
                let highlight = YYTextHighlight()
                highlight.setBackgroundBorder(highlightBorder)
                // 数据信息，用于稍后用户点击
                let tmpStr = text.string as NSString
                highlight.userInfo = [kSeeLinkAtName : tmpStr.substring(with: NSMakeRange(at.range.location + 1, at.range.length - 1))]
                text.setTextHighlight(highlight, range: at.range)
            }
        }
        
        // 匹配 [表情]
        let emoticonResults = SeeManager.regexEmoticon().matches(in: text.string, options: [], range: text.rangeOfAll())
        var emoClipLength = 0
        for emo: NSTextCheckingResult in emoticonResults {
            if emo.range.location == NSNotFound && emo.range.length <= 1 {
                continue
            }
            var range = emo.range
            range.location -= emoClipLength
            if (text.attribute(NSAttributedStringKey(rawValue: YYTextHighlightAttributeName), at: range.location, effectiveRange: nil) != nil) {
                continue
            }
            if (text.attribute(NSAttributedStringKey(rawValue: YYTextAttachmentAttributeName), at: range.location, effectiveRange: nil) != nil) {
                continue
            }
            let tmpStr = text.string as NSString
            let emoString = tmpStr.substring(with: range)
            let imagePath = SeeManager.emoticonDic()[emoString]
            if imagePath == nil {
                continue
            }
            let image = SeeManager.image(withPath: imagePath as! String)
            if image == nil {
                continue
            }
            let emoText = NSAttributedString.attachmentString(withEmojiImage: image!, fontSize: fontSize)
            text.replaceCharacters(in: range, with: emoText!)
            emoClipLength += range.length - 1
        }
        
        return text
    }
    
    
    /// 图片
    func layoutPics() {
        self.layoutPics(status: self.status.retweeted_status!, isRetweet: false)
    }
    
    func layoutRetweetPics() {
        self.layoutPics(status: self.status.retweeted_status!, isRetweet: true)
    }
    
    func layoutPics(status: SeeStatusModel, isRetweet: Bool) {
        
        if isRetweet {
            self.retweetPicSize = CGSize(width: 0, height: 0)
            self.retweetPicHeight = 0
        } else {
            self.picSize = CGSize(width: 0, height: 0)
            self.picHeight = 0
        }
        if status.pics.count == 0 {
            return
        }
        
        var picSize = CGSize(width: 0, height: 0)
        var picHeight: CGFloat = 0
        
        var len1_3 = (kSeeCellContentWidth + kSeeCellPaddingPic) / 3 - kSeeCellPaddingPic
        len1_3 = CGFloatPixelRound(len1_3)
        
        switch status.pics.count {
        case 1:
            let pic = self.status.pics.first
            let bmiddle = pic?.bmiddle
            if (pic != nil && pic!.keep_size) || (bmiddle == nil || bmiddle!.width < 1)  || (bmiddle == nil || bmiddle!.height < 1) {
                var maxLen = kSeeCellContentWidth / 2.0
                maxLen = CGFloatPixelRound(maxLen)
                picSize = CGSize(width: maxLen, height: maxLen)
                picHeight = maxLen
            } else {
                let maxLen = len1_3 * 2 + kSeeCellPaddingPic
                if bmiddle != nil && bmiddle!.width < bmiddle!.height {
                    picSize.width = CGFloat(bmiddle!.width / bmiddle!.height) * maxLen
                    picSize.height = maxLen
                } else if bmiddle != nil {
                    picSize.width = maxLen
                    picSize.height = CGFloat(bmiddle!.height / bmiddle!.width) * maxLen
                }
                picSize = CGSizePixelRound(picSize)
                picHeight = picSize.height
            }
            break
        case 2,3:
            picSize = CGSize(width: len1_3, height: len1_3)
            picHeight = len1_3
            break
        case 4,5,6:
            picSize = CGSize(width: len1_3, height: len1_3)
            picHeight = len1_3 * 2 + kSeeCellPaddingPic
            break
        default: // 7,8,9
            picSize = CGSize(width: len1_3, height: len1_3)
            picHeight = len1_3 * 3 + kSeeCellPaddingPic * 2
            break
        }
        
        if isRetweet {
            self.retweetPicSize = picSize
            self.retweetPicHeight = picHeight
        } else {
            self.picSize = picSize
            self.picHeight = picHeight
        }
    }
    
    
    /// 卡片
    func layoutCard() {
        self.layoutCard(status: self.status, isRetweet: false)
    }
    
    func layoutRetweetCard() {
        self.layoutCard(status: self.status.retweeted_status!, isRetweet: true)
    }
    
    func layoutCard(status: SeeStatusModel, isRetweet: Bool) {
        
    }
    
    
    /// Tag
    func layoutTag() {
        
        self.tagType = .none
        self.tagHeight = 0
        
        let tag = self.status.tag_struct.first
        if tag == nil || tag!.tag_name.count == 0 {
            return
        }
        
        let text = NSMutableAttributedString(string: tag!.tag_name)
        if tag!.tag_type == 1 {
            self.tagType = .place
            self.tagHeight = 40
            text.color = UIColor(white: 0.217, alpha: 1.000)
        } else {
            self.tagType = .normal
            self.tagHeight = 32
            if tag!.url_type_pic.count > 0 {
                let pic = self.attachment(fontSize: kSeeCellCardDescFontSize, imageURL: tag!.url_type_pic, shrink: true)
                text.insert(pic, at: 0)
            }
            // 高亮状态的背景
            let highlightBorder = YYTextBorder()
            highlightBorder.insets = UIEdgeInsetsMake(-2, 0, -2, 0)
            highlightBorder.cornerRadius = 2
            highlightBorder.fillColor = kSeeCellTextHighlightBackgroundColor
            
            text.setColor(kSeeCellTextHighlightColor, range: text.rangeOfAll())
            
            // 高亮状态
            let highlight = YYTextHighlight()
            highlight.setBackgroundBorder(highlightBorder)
            // 数据信息，用于稍后用户点击
            highlight.userInfo = [kSeeLinkTagName : tag as Any]
            text.setTextHighlight(highlight, range: text.rangeOfAll())
        }
        text.font = UIFont.systemFont(ofSize: kSeeCellCardDescFontSize)
        
        let container = YYTextContainer(size: CGSize(width: 9999, height: 9999))
        self.tagTextLayout = YYTextLayout(container: container, text: text)
        if self.tagTextLayout == nil {
            self.tagType = .none
            self.tagHeight = 0
        }
    }
    
    
    /// 工具栏
    func layoutToolbar() {
        
        let font = UIFont.systemFont(ofSize: kSeeCellToolbarFontSize)
        let container = YYTextContainer(size: CGSize(width: kScreenW, height: kSeeCellToolbarHeight))
        container.maximumNumberOfRows = 1
        
        let repostText = NSMutableAttributedString(string: self.status.reposts_count <= 0 ? "转发" : SeeManager.shortedNumberDesc(UInt(self.status.reposts_count)))
        repostText.font = font
        repostText.color = kSeeCellToolbarTitleColor
        self.toolbarRepostTextLayout = YYTextLayout(container: container, text: repostText)
        self.toolbarRepostTextWidth = CGFloatPixelRound(self.toolbarRepostTextLayout.textBoundingRect.size.width)
        
        let commentText = NSMutableAttributedString(string: self.status.comments_count <= 0 ? "评论" : SeeManager.shortedNumberDesc(UInt(self.status.comments_count)))
        commentText.font = font
        commentText.color = kSeeCellToolbarTitleColor
        self.toolbarCommentTextLayout = YYTextLayout(container: container, text: commentText)
        self.toolbarCommentTextWidth = CGFloatPixelRound(self.toolbarCommentTextLayout.textBoundingRect.size.width)
        
        let likeText = NSMutableAttributedString(string: self.status.attitudes_count <= 0 ? "赞" : SeeManager.shortedNumberDesc(UInt(self.status.attitudes_count)))
        likeText.font = font
        likeText.color = self.status.attitudes_status == 1 ? kSeeCellToolbarTitleHighlightColor : kSeeCellToolbarTitleColor
        self.toolbarLikeTextLayout = YYTextLayout(container: container, text: likeText)
        self.toolbarLikeTextWidth = CGFloatPixelRound(self.toolbarLikeTextLayout.textBoundingRect.size.width)
    }
    
    /// 名字
    func layoutName() {
        
        let user = self.status.user
        var nameStr = ""
        if !user.remark.isEmpty {
            nameStr = user.remark
        } else if(!user.screen_name.isEmpty) {
            nameStr = user.screen_name
        } else {
            nameStr = user.name
        }
        if nameStr.isEmpty {
            self.nameTextLayout = nil
            return
        }
        
        let nameText = NSMutableAttributedString(string: nameStr)
        
        // 蓝V
        if user.userVerifyType == .organization {
            let blueVImage = UIImage(named: "avatar_enterprise_vip")
            let blueVText = self.attachment(fontSize: kSeeCellNameFontSize, image: blueVImage!, shrink: false)
            nameText.appendString("")
            nameText.append(blueVText)
        }
        
        // VIP
        if user.mbrank > 0 {
            var yelllowVImage = UIImage(named: "common_icon_membership_level\(user.mbrank)")
            if yelllowVImage == nil {
                yelllowVImage = UIImage(named: "common_icon_membership")
            }
            let vipText = self.attachment(fontSize: kSeeCellNameFontSize, image: yelllowVImage!, shrink: false)
            nameText.appendString("")
            nameText.append(vipText)
        }
        
        nameText.font = UIFont.systemFont(ofSize: kSeeCellNameFontSize)
        nameText.color = user.mbrank > 0 ? kSeeCellNameOrangeColor : kSeeCellNameNormalColor
        nameText.lineBreakMode = .byCharWrapping
        
        let container = YYTextContainer(size: CGSize(width: kSeeCellNameWidth, height: 9999))
        container.maximumNumberOfRows = 1
        self.nameTextLayout = YYTextLayout(container: container, text: nameText)
    }
    
    /// 时间和来源
    func layoutSource() {
        
        let sourceText = NSMutableAttributedString()
        
        let createTime = SeeManager.string(withTimelineDate: self.status.created_at) as String
        
        // 时间
        if createTime.count > 0 {
            let timeText = NSMutableAttributedString(string: createTime)
            timeText.appendString("  ")
            timeText.font = UIFont.systemFont(ofSize: kSeeCellSourceFontSize)
            timeText.color = kSeeCellTimeNormalColor
            sourceText.append(timeText)
        }
        
        // 来源
        if self.status.source.count > 0 {
            do {
                /// 创建正则表达式对象
                let hrefRegex = try NSRegularExpression(pattern: "(?<=href=\").+(?=\" )", options: [])
                let textRegex = try NSRegularExpression(pattern: "(?<=>).+(?=<)", options: [])
                
                let hrefResult = hrefRegex.firstMatch(in: self.status.source, options: [], range: NSMakeRange(0, self.status.source.count))
                let textResult = textRegex.firstMatch(in: self.status.source, options: [], range: NSMakeRange(0, self.status.source.count))
                
                var href = ""
                var text = ""
                
                if hrefResult != nil && textResult != nil && hrefResult?.range.location != NSNotFound && textResult?.range.location != NSNotFound {
                    let str = self.status.source as NSString
                    href = str.substring(with: hrefResult!.range)
                    text = str.substring(with: textResult!.range)
                }
                
                if href.count > 0 && text.count > 0 {
                    let from = NSMutableAttributedString()
                    from.appendString("来自\(text)")
                    from.font = UIFont.systemFont(ofSize: kSeeCellSourceFontSize)
                    from.color = kSeeCellTimeNormalColor
                    if self.status.source_allowclick > 0 {
                        let range = NSMakeRange(3, text.count-1)
                        from.setColor(kSeeCellTextHighlightColor, range: range)
                        let backed = YYTextBackedString.init(string: href)
                        from.setTextBacked(backed, range: range)
                        
                        let border = YYTextBorder()
                        border.insets = UIEdgeInsetsMake(-2, 0, -2, 0)
                        border.fillColor = kSeeCellTextHighlightBackgroundColor
                        border.cornerRadius = 3
                        let highlight = YYTextHighlight()
                        if !href.isEmpty {
                            highlight.userInfo = [kSeeLinkHrefName : href]
                        }
                        highlight.setBackgroundBorder(border)
                        from.setTextHighlight(highlight, range: range)
                    }
                    sourceText.append(from)
                }
                
            } catch {
                
            }
        }
        
        if sourceText.length == 0 {
            self.sourceTextLayout = nil
        } else {
            let container = YYTextContainer(size: CGSize(width: kSeeCellNameWidth, height: 9999))
            container.maximumNumberOfRows = 1
            self.sourceTextLayout = YYTextLayout(container: container, text: sourceText)
        }
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
