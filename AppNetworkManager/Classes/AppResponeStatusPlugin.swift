//
//  AppResponeStatusPlugin.swift
//  AppNetworkManager
//
//  Created by Quan Li on 2019/8/27.
//  Copyright © 2019 williamoneilchina. All rights reserved.
//

import Foundation
import Result
import Moya


public class AppResponeStatusPlugin:PluginType{
    public typealias AppResponeStatusClosure = (_ statusCode: Int, _ target: TargetType) -> Void
    let statusClosure: AppResponeStatusClosure
    
    public init(statusClosure:@escaping AppResponeStatusClosure) {
        self.statusClosure = statusClosure
    }
    
    public func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        switch result {
        case .success(let response):
            statusClosure(response.statusCode,target)
        case .failure(let error):
            switch error{
            case .statusCode(let response):
                statusClosure(response.statusCode,target)
            default:break
            }
        }
    }
}
