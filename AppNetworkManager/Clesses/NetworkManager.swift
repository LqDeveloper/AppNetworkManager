//
//  NetworkManager.swift
//  AppNetworkManager
//
//  Created by Quan Li on 2019/8/27.
//  Copyright © 2019 williamoneilchina. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import Alamofire

public enum AppNetworkStatus {
    case app_ethernetOrWiFi
    case app_wwan
    case app_notReachable
    case app_unknown
}

open class AppNetworkManager {
    public static let shared = AppNetworkManager()
    public static let NetworkChange = Notification.Name(rawValue:"MSNetworkChange")
    private  var reachabilityManager:NetworkReachabilityManager?
    public var networkStatus:AppNetworkStatus = .app_unknown
    private var isStartNetwork = false
}


public extension AppNetworkManager{
    func startNetReachability() {
        if isStartNetwork{return}
        if reachabilityManager == nil{
            reachabilityManager = NetworkReachabilityManager()
        }
        isStartNetwork = true
        reachabilityManager?.listener = {[unowned self] status in
            var msStatus:AppNetworkStatus = .app_unknown
            switch status {
            case .unknown:
                msStatus = .app_unknown
            case .notReachable:
                msStatus = .app_notReachable
            case .reachable(let status):
                switch status{
                case .ethernetOrWiFi:
                    msStatus = .app_ethernetOrWiFi
                case .wwan:
                    msStatus = .app_wwan
                }
                break
            }
            self.networkStatus = msStatus
            NotificationCenter.default.post(name: AppNetworkManager.NetworkChange, object: nil)
        }
        reachabilityManager?.startListening()
    }
    
    func stopNetReachability() {
        isStartNetwork = false
        reachabilityManager?.stopListening()
    }
}
