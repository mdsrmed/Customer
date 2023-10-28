//
//  NetworkingManageCreateFailureMock.swift
//  CustomerTests
//
//  Created by Md Shohidur Rahman on 10/26/23.
//

import Foundation
@testable import Customer

class NetworkingManagerCreateFailureMock: NetworkingManagerImpl {
    
    func request<T>(session: URLSession, _ endpoint: Endpoint, type: T.Type) async throws -> T where T: Decodable {
        return Data() as! T
    }
    
    func request(session: URLSession, _ endpoint: Customer.Endpoint) async throws {
        throw NetworkingManager.NetworkingError.invalidURL
    }
}
