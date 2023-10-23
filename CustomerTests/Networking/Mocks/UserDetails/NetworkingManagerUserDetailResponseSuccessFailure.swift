//
//  NetworkingManagerUserDetailResponseSuccessFailure.swift
//  CustomerTests
//
//  Created by Md Shohidur Rahman on 10/23/23.
//

import Foundation
@testable import Customer


class NetworkingManagerUserDetailResponseSuccessFailureMock: NetworkingManagerImpl {
    func request<T>(session: URLSession, _ endpoint: Customer.Endpoint, type: T.Type) async throws -> T where T : Decodable, T : Encodable {
        throw NetworkingManager.NetworkingError.invalidURL
    }
    
    func request(session: URLSession, _ endpoint: Customer.Endpoint) async throws {
        
    }
    
    
}
