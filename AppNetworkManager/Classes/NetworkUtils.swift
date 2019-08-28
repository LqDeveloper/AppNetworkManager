//
//  NetworkUtils.swift
//  AppNetworkManager
//
//  Created by Quan Li on 2019/8/16.
//  Copyright © 2019 williamoneilchina. All rights reserved.
//

import Foundation
import Moya
import HandyJSON
import RxSwift
public extension Response{
    func mapToModel<T:HandyJSON>(_ type:T.Type)->T{
        let jsonString = String.init(data: data, encoding: String.Encoding.utf8)
        return T.deserialize(from: jsonString) ?? T.init()
    }
}


public extension PrimitiveSequence where TraitType == SingleTrait , ElementType == Response{
    func mapResonseToObject<T:HandyJSON>(type:T.Type) -> Single<T> {
        return flatMap { response -> Single<T> in
            return Single.just(response.mapToModel(T.self))
        }
    }
}
