//
//  SeeManager.swift
//  FWCommponents
//
//  Created by xfg on 2018/4/27.
//  Copyright © 2018年 xfg. All rights reserved.
//

import Foundation
import UIKit
import YYKit

class SeeManager: NSObject {
    
    static func stringWithTimeline(date: Date) -> String {
        
        let formatterYesterday = DateFormatter()
        formatterYesterday.dateFormat = "昨天 HH:mm"
        formatterYesterday.locale = NSLocale.current
        
        let formatterSameYear = DateFormatter()
        formatterSameYear.dateFormat = "M-d"
        formatterSameYear.locale = NSLocale.current
        
        let formatterFullDate = DateFormatter()
        formatterFullDate.dateFormat = "yy-M-dd"
        formatterFullDate.locale = NSLocale.current
        
        let now = Date()
        let delta = now.timeIntervalSince1970 - date.timeIntervalSince1970
        if delta < -60 * 10 { // 本地时间有问题
            return formatterFullDate.string(for: date)!
        }  else if (delta < 60 * 10) { // 10分钟内
            return "刚刚"
        } else if delta < 60 * 60 { // 1小时内
            return "\(delta / 60.0)分钟前"
        }
//        else if date.isToday {
//            return "\(delta / 60.0 / 60.0)小时前"
//        } else if date.isYesterday {
//            return formatterYesterday.string(from:date)
//        } else if (date.year == now.year) {
//            return formatterSameYear.string(from:date)
//        }
        else {
            return formatterFullDate.string(from:date)
        }
    }
    
    static func shorted(number: Int) -> String {
        
        if number <= 9999 {
            return "\(number)"
        }
        if number <= 9999999 {
            return "\(number / 10000)万"
        }
        return "\(number / 10000000)千万"
    }
}
