//
//  UserDetailResponse.swift
//  Customer
//
//  Created by Md Shohidur Rahman on 9/8/23.
//

import Foundation


//MARK: - UserDetailResponse
struct UserDetailResponse: Codable,Equatable {
    let data: User?
    let support: Support?
}


