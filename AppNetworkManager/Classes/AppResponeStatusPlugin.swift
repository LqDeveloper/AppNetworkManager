//
//  AppResponeStatusPlugin.swift
//  AppNetworkManager
//
//  Created by Quan Li on 2019/8/27.
//  Copyright © 2019 williamoneilchina. All rights reserved.
//

import Foundation
import Moya

public protocol AppResponeStatusDelegate:AnyObject{
    func didReceiveResponse(statusCode: Int,urlString:String)
}

public class AppResponeStatusPlugin:PluginType{
    weak var delegate:AppResponeStatusDelegate?
    
    public init(delegate:AppResponeStatusDelegate) {
        self.delegate = delegate
    }
    
    public func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        let urlString = "\(target.baseURL.absoluteString)\(target.path)"
        switch result {
        case .success(let response):
            delegate?.didReceiveResponse(statusCode: response.statusCode, urlString: urlString)
        case .failure(let error):
            switch error{
            case .statusCode(let response):
                delegate?.didReceiveResponse(statusCode: response.statusCode, urlString: urlString)
            default:break
            }
        }
    }
}
