//
//  EmayaAPI.swift
//  EmayaMVVM
//
//  Created by bryangarcia on 15/4/25.
//

import SwiftUI


enum EmayaAPI: APIEndpoint{
    case fetchShopList
    case fetchItemDetail(id: String)
    
    var baseURL: URL {
        guard let url = URL(string: K.API.baseURL) else {
            fatalError("⚠️ BASE_URL Invalid")
        }
        return url
    }

    var path: String {
        switch self {
        case .fetchShopList:
            return "products"
        case .fetchItemDetail(let id):
            return "products/\(id)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchShopList:
            return .get
        case .fetchItemDetail:
            return .get
        }
    }
    
    var headers: [String : String]? {
        var headers: [String: String] = [
            "Content-Type": "application/json"
        ]
        return headers
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .fetchShopList:
            return nil
        case .fetchItemDetail:
            return nil
        }
    }
    
    func bodyToData() throws -> Data? {
        switch self {
        case .fetchShopList, .fetchItemDetail:
            return nil
        }
    }
    
}
