//
//  SeeItemModel.swift
//  FWCommponents
//
//  Created by xfg on 2018/4/26.
//  Copyright © 2018年 xfg. All rights reserved.
//

import Foundation
import UIKit

/// 图片标记
///
/// - none: 正常图片
/// - long: 长图
/// - gif: GIF
enum SeePictureBadgeType: Int {
    case none
    case long
    case gif
}

class SeeItemModel: FWBaseModel {
    
    let ad = [SeeAdModel]()
    let advertises = [SeeAdvertisesModel]()
    let gsid = [SeeGsidModel]()
    let interval = 0
    let uve_blank = 0
    let has_unread = 0
    let total_number = 0
    let since_id = ""
    let max_id = ""
    let previous_cursor = ""
    let next_cursor = ""
    let statuses = [SeeStatusesModel]()
    
}

class SeeStatusesModel: FWBaseModel {
    
    let id = ""
    let idstr = ""
    let mid = ""
    let rid = ""
    /// 发布时间
    let created_at = ""
    
    let user = SeeUserModel()
    let userType = 0
    
    /// 标题栏 (通常为nil)
    let title = SeeTitleModel()
    /// 微博VIP背景图，需要替换 "os7"
    let pic_bg = ""
    /// 正文
    let text = ""
    /// 缩略图
    let thumbnail_pic = ""
    /// 中图
    let bmiddle_pic = ""
    /// 大图
    let original_pic = ""
    
    /// 转发微博
//    let retweeted_status = SeeStatusesModel()
    
    let pic_ids = [String]()
    let pic_infos = [String : SeePictureModel]()
    
    let pics = [SeePictureModel]()
    let url_struct = [SeeURLModel]()
    let topic_struct = [SeeTopicModel]()
    let tag_struct = [SeeTagModel]()
    let page_info = SeePageInfoModel()
    
    /// 是否收藏
    let favorited = false
    /// 是否截断
    let truncated = false
    
    /// 转发数
    let reposts_count = 0
    /// 评论数
    let comments_count = 0
    /// 赞数
    let attitudes_count = 0
    /// 是否已赞 0:没有
    let attitudes_status = 0
    let recom_state = 0
    
    let in_reply_to_screen_name = ""
    let in_reply_to_status_id = ""
    let in_reply_to_user_id = ""
    
    /// 来自 XXX
    let source = ""
    let source_type = 0
    /// 来源是否允许点击
    let source_allowclick = 0
    
    let geo = [String : String]()
    /// 地理位置
    let annotations = [String]()
    let biz_feature = 0
    let mlevel = 0
    
    let mblogid = ""
    let mblogtypename = ""
    let scheme = ""
    let visible = [String : String]()
    let darwin_tags = [String]()
    
}

/// 用户
class SeeUserModel: FWBaseModel {
    
    
}

/// 标题
class SeeTitleModel: FWBaseModel {
    
    let baseColor = 0
    /// 文本，例如"仅自己可见"
    let text = ""
    /// 图标URL，需要加Default
    let iconURL = ""
    
}

/// 图片
class SeePictureModel: FWBaseModel {
    
    let pic_id = ""
    let object_id = ""
    let photo_tag = 0
    /// YES:固定为方形 NO:原始宽高比
    let keep_size = false
    
    /// w:180
    let thumbnail = SeePictureMetadataModel()
    /// w:360 (列表中的缩略图)
    let bmiddle = SeePictureMetadataModel()
    /// w:480
    let middlePlus = SeePictureMetadataModel()
    /// w:720 (放大查看)
    let large = SeePictureMetadataModel()
    /// (查看原图)
    let largest = SeePictureMetadataModel()
    let original = SeePictureMetadataModel()
    let badgeType = SeePictureMetadataModel()
    
}

/// 一个图片的元数据
class SeePictureMetadataModel: FWBaseModel {
    
    /// Full image url
    let url = ""
    /// pixel width
    let width = 0
    /// pixel height
    let height = 0
    /// "WEBP" "JPEG" "GIF"
    let type = ""
    /// Default:1
    let cut_type = 0
    let badgeType: SeePictureBadgeType = .none
    
}

/// 链接
class SeeURLModel: FWBaseModel {
    
    let result = false
    /// 短域名 (原文)
    let short_url = ""
    /// 原始链接
    let ori_url = ""
    /// 显示文本，例如"网页链接"，可能需要裁剪(24)
    let url_title = ""
    /// 链接类型的图片URL
    let url_type_pic = ""
    /// 0:一般链接 36地点 39视频/图片
    let url_type = ""
    let log = ""
    let actionlog = ""
    /// 对应着 SeePageInfoModel
    let page_id = ""
    let storage_type = ""
    
    
    /// 如果是图片，则会有下面这些，可以直接点开看
    let pic_ids = [String]()
    let pic_infos = [String : SeePictureModel]()
    let pics = [SeePictureModel]()
    
}

/// 话题
class SeeTopicModel: FWBaseModel {
    
    /// 话题标题
    let topic_title = ""
    /// 话题链接 sinaweibo://
    let topic_url = ""
    
}

/// 标签
class SeeTagModel: FWBaseModel {
    
    let tag_hidden = ""
    /// 标签名字，例如"上海·上海文庙"
    let tag_name = ""
    /// 链接 sinaweibo://...
    let tag_scheme = ""
    /// 1 地点 2其他
    let tag_type = ""
    /// 需要加 _default
    let url_type_pic = ""
    
}

/**
 卡片 (样式有多种，最常见的是下方这样)
 -----------------------------
 title
 pic     title        button
 tips
 -----------------------------
 */
class SeePageInfoModel: FWBaseModel {
    
    /// 页面标题，例如"上海·上海文庙"
    let page_title = ""
    let page_id = ""
    /// 页面描述，例如"上海市黄浦区文庙路215号"
    let page_desc = ""
    /// 类型，例如"place" "video"
    let object_type = ""
    /// 提示，例如"4222条微博"
    let tips = ""
    let content1 = ""
    let content2 = ""
    let content3 = ""
    let content4 = ""
    let object_id = ""
    /// 真实链接，例如 http://v.qq.com/xxx
    let scheme = ""
    let buttons = [SeeButtonLinkModel]()
    
    let is_asyn = 0
    let type = 0
    /// 链接 sinaweibo://...
    let page_url = ""
    /// 图片URL，不需要加(_default) 通常是左侧的方形图片
    let page_pic = ""
    /// Badge 图片URL，不需要加(_default) 通常放在最左上角角落里
    let type_icon = ""
    
    let act_status = 0
    let actionlog = [String : String]()
    let media_info = [String : String]()
    
}

/// 按钮
class SeeButtonLinkModel: FWBaseModel {
    
    /// 按钮图片URL (需要加_default)
    let pic = ""
    /// 按钮文本，例如"点评"
    let name = ""
    let type = ""
    let params = [String : String]()
    
}

class SeeAdModel: FWBaseModel {
    
    
}

class SeeAdvertisesModel: FWBaseModel {
    
    
}

class SeeGsidModel: FWBaseModel {
    
    
}




