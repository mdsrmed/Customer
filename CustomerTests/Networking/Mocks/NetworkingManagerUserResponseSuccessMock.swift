//
//  NetworkingManagerUserResponseSuccessMock.swift
//  CustomerTests
//
//  Created by Md Shohidur Rahman on 10/21/23.
//

import Foundation
@testable import Customer

class NetworkingManagerUserResponseSuccessMock: NetworkingManagerImpl {
    func request<T>(session: URLSession, _ endpoint: Customer.Endpoint, type: T.Type) async throws -> T where T : Decodable, T : Encodable {
        return try StaticJSONMapper.decode(file: "UsersStaticData", type: UsersResponse.self) as! T 
    }
    
    func request(session: URLSession, _ endpoint: Customer.Endpoint) async throws {
    }
    
    
}

