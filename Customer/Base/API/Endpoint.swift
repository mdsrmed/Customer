//
//  Endpoint.swift
//  Customer
//
//  Created by Md Shohidur Rahman on 10/4/23.
//

import Foundation


enum Endpoint {
    case customer
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
        
        #if DEBUG
        urlComponents.queryItems = [
        URLQueryItem(name: "delay", value: "1")]
        #endif
        
        return urlComponents.url
    }
}

extension Endpoint {
    enum MethodType {
        case GET
        case POST(data: Data?)
    }
}
