//
//  SeeViewModel.swift
//  FWCommponents
//
//  Created by xfg on 2018/4/24.
//  Copyright © 2018年 xfg. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

/// 网络请求成功回调
typealias NetSuccessBlock = FWVoidBlock
/// 网络请求失败回调
typealias NetFailureBlock = FWVoidBlock

class SeeViewModel: FWBaseViewModel {
    
    var responseLayouts: [SeeStatusLayout] = []
    
    override init() {
        super.init()
    }
}

extension SeeViewModel {
    
    /// 模拟网络请求
    public func requestData(successBlock: (FWVoidBlock?) = nil, failureBlock: (FWVoidBlock?) = nil) {
        
        var tmpLayouts: [SeeStatusLayout] = []
        
        DispatchQueue.global().async {
            for index in 0...7 {
                let path = Bundle.main.path(forResource: "weibo_\(index)", ofType: "json")
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path!))
                    // 原生方法
                    // let json:Any =tryJSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.mutableContainers)
                    // let jsonDic = jsonas!Dictionary<String,Any>
                    let json = JSON(data)
                    
                    let seeModel = SeeModel.deserialize(from: json.rawString())
                    guard let seeIm = seeModel else {
                        if failureBlock != nil {
                            failureBlock!()
                        }
                        return
                    }
                    for status: SeeStatusModel in seeIm.statuses {
                        let layout = SeeStatusLayout(status: status, style: SeeLayoutStyle.Timeline)
                        tmpLayouts.append(layout)
                    }
                } catch {
                    
                }
            }
            
            DispatchQueue.main.async {
                if tmpLayouts.count > 0 && successBlock != nil {
                    self.responseLayouts.removeAll()
                    self.responseLayouts = tmpLayouts
                    successBlock!()
                } else if failureBlock != nil {
                    failureBlock!()
                }
            }
        }
    }
}
