//
//  AppNetworkActivityPlugin.swift
//  AppNetworkManager
//
//  Created by Quan Li on 2019/8/28.
//  Copyright © 2019 williamoneilchina. All rights reserved.
//

import Foundation
import Result
import Moya

public protocol AppNetworkActivityDelegate:AnyObject{
    func moyaRequestStart(urlString:String,target: TargetType)
    func moyaRequestEnd(urlString:String,response:Data,target: TargetType)
}

public final class AppNetworkActivityPlugin: PluginType {
    
    weak var delegate:AppNetworkActivityDelegate?
    
    public init(delegate:AppNetworkActivityDelegate) {
        self.delegate = delegate
    }
    
    public func willSend(_ request: RequestType, target: TargetType) {
        let urlString = "\(target.baseURL.absoluteString)\(target.path)"
        delegate?.moyaRequestStart(urlString: urlString,target: target)
    }
    
    public func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
        let urlString = "\(target.baseURL.absoluteString)\(target.path)"
        switch result {
        case .success(let response):
            delegate?.moyaRequestEnd(urlString: urlString, response: response.data,target: target)
        case .failure(let error):
            switch error{
            case .statusCode(let response):
                delegate?.moyaRequestEnd(urlString: urlString, response: response.data,target: target)
            default:break
            }
        }
    }
}
