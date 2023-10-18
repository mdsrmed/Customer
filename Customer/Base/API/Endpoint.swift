//
//  Endpoint.swift
//  Customer
//
//  Created by Md Shohidur Rahman on 10/4/23.
//

import Foundation


enum Endpoint {
    case customer(page: Int)
    case detail(id: Int)
    case create(submissionData: Data?)
    
    
    var host: String { "reqres.in" }
    
    var path: String {
        switch self {
        case .customer,.create:
            return "/api/users"
        case .detail(let id):
            return "/api/users/\(id)"
        }
    }
    
    var methodType: MethodType {
        switch self {
        case .customer,
             .detail:
            return .GET
        case .create(let data):
            return .POST(data: data)
        }
    }
    
    
    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = host
        urlComponents.path = path
        
        var requestQueryItems = queryItem?.compactMap { item in
            
            URLQueryItem(name: item.key , value: item.value)
        }
        
        #if DEBUG
        requestQueryItems?.append(URLQueryItem(name: "delay", value: "1"))
        #endif
        
        urlComponents.queryItems = requestQueryItems
        
        return urlComponents.url
    }
    
    var queryItem: [String: String]? {
        switch self {
        case .customer(let page):
            return ["page": "\(page)"]
            
        default:
            return nil
        }
    }
}

extension Endpoint {
    enum MethodType: Equatable {
        case GET
        case POST(data: Data?)
    }
}
