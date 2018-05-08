//
//  SeeModel.swift
//  FWCommponents
//
//  Created by xfg on 2018/4/26.
//  Copyright © 2018年 xfg. All rights reserved.
//

import Foundation
import UIKit
import HandyJSON

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

/// 认证方式
///
/// - none: 没有认证
/// - standard: 个人认证，黄V
/// - organization: 官方认证，蓝V
/// - club: 达人认证，红星
enum SeeUserVerifyType: Int {
    case none
    case standard
    case organization
    case club
}

/// 表情类型
///
/// - image: 图片表情
/// - emoji: Emoji表情
enum SeeEmoticonType: Int {
    case image
    case emoji
}


class SeeModel: FWBaseModel {
    
    var ad = [SeeAdModel]()
    var advertises = [SeeAdvertisesModel]()
    var gsid = [SeeGsidModel]()
    var interval = 0
    var uve_blank = 0
    var has_unread = 0
    var total_number = 0
    var since_id = ""
    var max_id = ""
    var previous_cursor = ""
    var next_cursor = ""
    var statuses = [SeeStatusModel]()
    
}

class SeeStatusModel: FWBaseModel {
    
    var id = ""
    var idstr = ""
    var mid = ""
    var rid = ""
    /// 发布时间
    var created_at: Date?
    
    var user = SeeUserModel()
    var userType = 0
    
    /// 标题栏 (通常为nil)
    var title = SeeTitleModel()
    /// 微博VIP背景图，需要替换 "os7"
    var pic_bg = ""
    /// 正文
    var text = ""
    /// 缩略图
    var thumbnail_pic = ""
    /// 中图
    var bmiddle_pic = ""
    /// 大图
    var original_pic = ""
    
    /// 转发微博
    var retweeted_status: SeeStatusModel? = nil
    
    var pic_ids = [String]()
    var pic_infos = [String : SeePictureModel]()
    
    var pics = [SeePictureModel]()
    var url_struct = [SeeURLModel]()
    var topic_struct = [SeeTopicModel]()
    var tag_struct = [SeeTagModel]()
    var page_info = SeePageInfoModel()
    
    /// 是否收藏
    var favorited = false
    /// 是否截断
    var truncated = false
    
    /// 转发数
    var reposts_count = 0
    /// 评论数
    var comments_count = 0
    /// 赞数
    var attitudes_count = 0
    /// 是否已赞 0:没有
    var attitudes_status = 0
    var recom_state = 0
    
    var in_reply_to_screen_name = ""
    var in_reply_to_status_id = ""
    var in_reply_to_user_id = ""
    
    /// 来自 XXX
    var source = ""
    var source_type = 0
    /// 来源是否允许点击
    var source_allowclick = 0
    
    var geo = [String : String]()
    /// 地理位置
    var annotations = [String]()
    var biz_feature = 0
    var mlevel = 0
    
    var mblogid = ""
    var mblogtypename = ""
    var scheme = ""
    var visible = [String : String]()
    var darwin_tags = [String]()
    
    override func mapping(mapper: HelpingMapper) {
        // 指定 id 字段用 "cat_id" 去解析
        //        mapper.specify(property: &id, name: "cat_id")
        //
        //        // 指定 parent 字段用这个方法去解析
        //        mapper.specify(property: &parent) { (rawString) -> (String, String) in
        //            var parentNames = rawString.characters.split{$0 == "/"}.map(String.init)
        //            return (parentNames[0], parentNames[1])
        //        }
        
        mapper <<<
            created_at <-- CustomDateFormatTransform(formatString: "EEE MMM dd HH:mm:ss zzz yyyy")
    }
    
    override func didFinishMapping() {
        
        if self.pic_ids.count != 0 {
            var tmpPics = [SeePictureModel]()
            for picId in pic_ids {
                let pic = pic_infos[picId]
                if pic != nil {
                    tmpPics.append(pic!)
                }
            }
            pics = tmpPics
        }
    }
    
}

/// 用户
class SeeUserModel: FWBaseModel {
    
    /// id (int)
    var id = 0
    /// id (string)
    var idstr = ""
    /// 0:none 1:男 2:女
    var gender = 0
    /// "m":男 "f":女 "n"未知
    var genderString = ""
    /// 个人简介
    var desc = ""
    /// 个性域名
    var domain = ""
    
    /// 昵称
    var name = ""
    /// 友好昵称
    var screen_name = ""
    /// 备注
    var remark = ""
    
    /// 粉丝数
    var followers_count = 0
    /// 关注数
    var friends_count = 0
    /// 好友数 (双向关注)
    var bi_followers_count = 0
    /// 收藏数
    var favourites_count = 0
    /// 微博数
    var statuses_count = 0
    /// 话题数
    var topics_count = 0
    /// 屏蔽数
    var blocked_count = 0
    var pagefriends_count = 0
    var follow_me = false
    var following = false
    
    /// 省
    var province = ""
    /// 市
    var city = ""
    
    /// 博客地址
    var url = ""
    /// var profile_image_url = ""
    var profile_image_url = ""
    /// 头像 180*180
    var avatar_large = ""
    /// 头像 原图
    var avatar_hd = ""
    /// 封面图 920x300
    var cover_image = ""
    var cover_image_phone = ""
    
    var profile_url = ""
    var type = 0
    var ptype = 0
    var mbtype = 0
    /// 微博等级 (LV)
    var urank = 0
    var uclass = 0
    var ulevel = 0
    /// 会员等级 (橙名 VIP)
    var mbrank = 0
    var star = 0
    var level = 0
    /// 注册时间
    var created_at = ""
    var allow_all_act_msg = false
    var allow_all_comment = false
    var geo_enabled = false
    var online_status = 0
    /// 所在地
    var location = ""
    var icons = [String : String]()
    var weihao = ""
    var badge_top = ""
    var block_app = 0
    var block_word = 0
    var has_ability_tag = 0
    /// 信用积分
    var credit_score = 0
    /// 勋章
    var badge = [String : NSNumber]()
    var lang = ""
    var user_ability = 0
    var extend = [String : String]()
    
    /// 微博认证 (大V)
    var verified = false
    var verified_type = 0
    var verified_level = 0
    var verified_state = 0
    var verified_contact_email = ""
    var verified_contact_mobile = ""
    var verified_trade = ""
    var verified_contact_name = ""
    var verified_source_url = ""
    var verified_reason = ""
    var verified_reason_modified = ""
    var verified_reason_url = ""
    var verified_source = ""
    
    var userVerifyType = SeeUserVerifyType.none
    
}

/// 标题
class SeeTitleModel: FWBaseModel {
    
    var baseColor = 0
    /// 文本，例如"仅自己可见"
    var text = ""
    /// 图标URL，需要加Default
    var iconURL = ""
    
}

/// 图片
class SeePictureModel: FWBaseModel {
    
    var pic_id = ""
    var object_id = ""
    var photo_tag = 0
    /// YES:固定为方形 NO:原始宽高比
    var keep_size = false
    
    /// w:180
    var thumbnail = SeePictureMetadataModel()
    /// w:360 (列表中的缩略图)
    var bmiddle = SeePictureMetadataModel()
    /// w:480
    var middlePlus = SeePictureMetadataModel()
    /// w:720 (放大查看)
    var large = SeePictureMetadataModel()
    /// (查看原图)
    var largest = SeePictureMetadataModel()
    var original = SeePictureMetadataModel()
    var badgeType = SeePictureMetadataModel()
    
}

/// 一个图片的元数据
class SeePictureMetadataModel: FWBaseModel {
    
    /// Full image url
    var url = ""
    /// pixel width
    var width = 0
    /// pixel height
    var height = 0
    /// "WEBP" "JPEG" "GIF"
    var type = ""
    /// Default:1
    var cut_type = 0
    var badgeType: SeePictureBadgeType = .none
    
}

/// 链接
class SeeURLModel: FWBaseModel {
    
    var result = false
    /// 短域名 (原文)
    var short_url = ""
    /// 原始链接
    var ori_url = ""
    /// 显示文本，例如"网页链接"，可能需要裁剪(24)
    var url_title = ""
    /// 链接类型的图片URL
    var url_type_pic = ""
    /// 0:一般链接 36地点 39视频/图片
    var url_type = ""
    var log = ""
    var actionlog = ""
    /// 对应着 SeePageInfoModel
    var page_id = ""
    var storage_type = ""
    
    
    /// 如果是图片，则会有下面这些，可以直接点开看
    var pic_ids = [String]()
    var pic_infos = [String : SeePictureModel]()
    var pics = [SeePictureModel]()
    
}

/// 话题
class SeeTopicModel: FWBaseModel {
    
    /// 话题标题
    var topic_title = ""
    /// 话题链接 sinaweibo://
    var topic_url = ""
    
}

/// 标签
class SeeTagModel: FWBaseModel {
    
    var tag_hidden = ""
    /// 标签名字，例如"上海·上海文庙"
    var tag_name = ""
    /// 链接 sinaweibo://...
    var tag_scheme = ""
    /// 1 地点 2其他
    var tag_type = 0
    /// 需要加 _default
    var url_type_pic = ""
    
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
    var page_title = ""
    var page_id = ""
    /// 页面描述，例如"上海市黄浦区文庙路215号"
    var page_desc = ""
    /// 类型，例如"place" "video"
    var object_type = ""
    /// 提示，例如"4222条微博"
    var tips = ""
    var content1 = ""
    var content2 = ""
    var content3 = ""
    var content4 = ""
    var object_id = ""
    /// 真实链接，例如 http://v.qq.com/xxx
    var scheme = ""
    var buttons = [SeeButtonLinkModel]()
    
    var is_asyn = 0
    var type = 0
    /// 链接 sinaweibo://...
    var page_url = ""
    /// 图片URL，不需要加(_default) 通常是左侧的方形图片
    var page_pic = ""
    /// Badge 图片URL，不需要加(_default) 通常放在最左上角角落里
    var type_icon = ""
    
    var act_status = 0
    var actionlog = [String : String]()
    var media_info = [String : String]()
    
}

/// 按钮
class SeeButtonLinkModel: FWBaseModel {
    
    /// 按钮图片URL (需要加_default)
    var pic = ""
    /// 按钮文本，例如"点评"
    var name = ""
    var type = ""
    var params = [String : String]()
    
}

class SeeAdModel: FWBaseModel {
    
    
}

class SeeAdvertisesModel: FWBaseModel {
    
    
}

class SeeGsidModel: FWBaseModel {
    
    
}


