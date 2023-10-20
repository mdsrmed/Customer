//
//  UsersResponse.swift
//  Customer
//
//  Created by Md Shohidur Rahman on 9/8/23.
//

import Foundation

// MARK: - UsersResponse
struct UsersResponse: Codable, Equatable {
    let page, perPage, total, totalPages: Int?
    let data: [User]
    let support: Support
}
