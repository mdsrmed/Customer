//
//  CreateValidator.swift
//  Customer
//
//  Created by Md Shohidur Rahman on 10/3/23.
//

import Foundation

protocol CreateValidatorImpl {
    func validate(_ customer: NewCustomer) throws
}


struct CreateValidator: CreateValidatorImpl{
    
    func validate(_ customer: NewCustomer) throws {
        
        if customer.firstName.isEmpty {
            throw CreateValidatorError.invalidFirstName
        }
        
        if customer.lastName.isEmpty {
            throw CreateValidatorError.invalidLastName
        }
        
        if customer.job.isEmpty {
            throw CreateValidatorError.invalidJob
        }
        
    }
}

extension CreateValidator {
    enum CreateValidatorError: LocalizedError {
        case invalidFirstName
        case invalidLastName
        case invalidJob
        
        var errorDescription: String? {
            switch self {
            case .invalidFirstName:
                return "First name can't be empty"
            case .invalidLastName:
                return "Last name can't be empty"
            case .invalidJob:
                return "Job can't be empty"
            }
        }
    }
}
