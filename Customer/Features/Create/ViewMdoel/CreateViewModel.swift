//
//  CreateViewModel.swift
//  Customer
//
//  Created by Md Shohidur Rahman on 9/17/23.
//

import Foundation


final class CreateViewModel: ObservableObject {
    @Published var customer = NewCustomer()
    @Published private(set) var state: SubmissionState?
    @Published private(set) var error: FormError?
    @Published var hasError = false
    
    
    private let validator = CreateValidator()
    
    func create(){
        
        do {
            try validator.validate(customer)
            
            state = .submitting
            
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            let data = try? encoder.encode(customer)
            
            
            NetworkingManager.shared.request(methodType: .POST(data: data), "https://reqres.in/api/users?delay=3") { [weak self] res in
                
                DispatchQueue.main.async {
                    switch res {
                        
                    case .success:
                        self?.state = .successful
                        
                    case .failure(let err):
                        self?.state = .unsuccessful
                        self?.hasError = true
                        if let networkingError = err as? NetworkingManager.NetworkingError{
                            self?.error = .networking(error: networkingError)
                        }
                        
                        
                    }
                    
                }
            }
            
        } catch {
            self.hasError = true
            if let validationError = error as? CreateValidator.CreateValidatorError {
                self.error = .validation(error: validationError)
            }
        
        }
        
        
    }
}

extension CreateViewModel {
    enum SubmissionState {
        case unsuccessful
        case successful
        case submitting
    }
}

extension CreateViewModel {
    enum FormError: LocalizedError {
        case networking(error: LocalizedError)
        case validation(error: LocalizedError)
        
        var errorDescription: String? {
            switch self {
            case .networking(let err),
                 .validation(let err):
                return err.errorDescription
            }
        }
    }
}
