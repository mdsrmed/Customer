//
//  CreateValidatorFailureMock.swift
//  CustomerTests
//
//  Created by Md Shohidur Rahman on 10/26/23.
//

import Foundation
@testable import Customer

struct CreateValidatorFailureMock: CreateValidatorImpl {
    func validate(_ customer: Customer.NewCustomer) throws {
        throw CreateValidator.CreateValidatorError.invalidFirstName
    }
    
    
}
