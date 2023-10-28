//
//  CreateViewModel.swift
//  Customer
//
//  Created by Md Shohidur Rahman on 9/17/23.
//

import Foundation

@MainActor
final class CreateViewModel: ObservableObject {
    @Published var customer = NewCustomer()
    @Published private(set) var state: SubmissionState?
    @Published private(set) var error: FormError?
    @Published var hasError = false
    
    
    private let networikingManager: NetworkingManagerImpl!
    private let validator: CreateValidatorImpl!
    
    init(networkingManager: NetworkingManagerImpl = NetworkingManager.shared,
         validator: CreateValidatorImpl = CreateValidator()){
        self.networikingManager = networkingManager
        self.validator = validator
    }
    
    func create() async {
        do {
            try validator.validate(customer)
            
            state = .submitting
            
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            let data = try encoder.encode(customer)
            try await networikingManager.request(session: .shared, .create(submissionData: data))
            state = .successful
            
        } catch {
            self.hasError = true
            state = .unsuccessful
            
            switch error {
            case is NetworkingManager.NetworkingError:
                self.error = .networking(error: error as! NetworkingManager.NetworkingError)
                
            case is CreateValidator.CreateValidatorError:
                self.error = .validation(error: error as! CreateValidator.CreateValidatorError)
                
            default:
                self.error = .system(error: error)
            }
        }
    }
    
//    func create(){
//        
//        do {
//            try validator.validate(customer)
//            
//            state = .submitting
//            
//            let encoder = JSONEncoder()
//            encoder.keyEncodingStrategy = .convertToSnakeCase
//            let data = try? encoder.encode(customer)
//            
//            
//            NetworkingManager.shared.request(.create(submissionData: data)) { [weak self] res in
//                
//                DispatchQueue.main.async {
//                    switch res {
//                        
//                    case .success:
//                        self?.state = .successful
//                        
//                    case .failure(let err):
//                        self?.state = .unsuccessful
//                        self?.hasError = true
//                        if let networkingError = err as? NetworkingManager.NetworkingError{
//                            self?.error = .networking(error: networkingError)
//                        }
//                        
//                        
//                    }
//                    
//                }
//            }
//            
//        } catch {
//            self.hasError = true
//            if let validationError = error as? CreateValidator.CreateValidatorError {
//                self.error = .validation(error: validationError)
//            }
//        
//        }
//        
//        
//    }
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
        case system(error: Error)
        
        var errorDescription: String? {
            switch self {
            case .networking(let err),
                 .validation(let err):
                return err.errorDescription
                
            case .system(let err):
                return err.localizedDescription
            }
        }
    }
}

extension CreateViewModel.FormError: Equatable {
    static func == (lhs: CreateViewModel.FormError, rhs: CreateViewModel.FormError) -> Bool {
        switch (lhs, rhs) {
        case (.networking(let lhsType), .networking(let rhsType)):
            return  lhsType.errorDescription == rhsType.errorDescription
        case (.validation(let lhsType), .validation(let rhsType)):
            return  lhsType.errorDescription == rhsType.errorDescription
        case (.system(let lhsType), .system(let rhsType)):
            return  lhsType.localizedDescription == rhsType.localizedDescription
        default:
            return false
        }
    }
}
