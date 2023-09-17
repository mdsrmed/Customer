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
    
    func create(){
        
        
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        let data = try? encoder.encode(customer)
        
        
        NetworkingManager.shared.request(methodType: .POST(data: data), "https://reqres.in/api/users") { [weak self] res in
            
            DispatchQueue.main.async {
                switch res {
                    
                case .success:
                    self?.state = .successful
                    
                case .failure(_):
                    self?.state = .unsuccessful
                    
                }
                
            }
        }
    }
}

extension CreateViewModel {
    enum SubmissionState {
        case unsuccessful
        case successful
    }
}
