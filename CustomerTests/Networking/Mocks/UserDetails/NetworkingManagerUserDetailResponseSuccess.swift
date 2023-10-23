//
//  NetworkingManagerUserDetailResponseSuccess.swift
//  CustomerTests
//
//  Created by Md Shohidur Rahman on 10/23/23.
//

import Foundation
@testable import Customer

class NetworkingManagerUserDetailResponseSuccessMock: NetworkingManagerImpl {
    func request<T>(session: URLSession, _ endpoint: Customer.Endpoint, type: T.Type) async throws -> T where T : Decodable, T : Encodable {
        return try StaticJSONMapper.decode(file: "SingleUserData", type: UserDetailResponse.self) as! T
    }
    
    func request(session: URLSession, _ endpoint: Customer.Endpoint) async throws {
        
    }
    
    
}
