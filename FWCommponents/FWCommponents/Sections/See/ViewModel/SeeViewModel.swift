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
    
    var responseModelList: [SeeItemModel] = []
    
    override init() {
        super.init()
        
    }
}

extension SeeViewModel {
    
    /// 模拟网络请求
    public func requestData(successBlock: (FWVoidBlock?) = nil, failureBlock: (FWVoidBlock?) = nil) {
        
        self.responseModelList.removeAll()
        
        DispatchQueue.global().async {
            for index in 0...7 {
                let path = Bundle.main.path(forResource: "weibo_\(index)", ofType: "json")
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path!))
                    let json = JSON(data)
                    
                    let seeItemModel = SeeItemModel.deserialize(from: json.rawString())
                    guard let seeIm = seeItemModel else {
                        return
                    }
                    self.responseModelList.append(seeIm)
                    
                } catch {
                    
                }
            }
            
            if self.responseModelList.count > 0 && successBlock != nil {
                successBlock!()
            } else if failureBlock != nil {
                failureBlock!()
            }
        }
    }
}
