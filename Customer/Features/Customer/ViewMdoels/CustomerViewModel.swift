//
//  CustomerViewModel.swift
//  Customer
//
//  Created by Md Shohidur Rahman on 9/16/23.
//

import Foundation



@MainActor
final class CustomerViewModel: ObservableObject {
    
    @Published private(set) var users: [User] = []
    @Published private(set) var error: NetworkingManager.NetworkingError?
    @Published private(set) var isLoading = false
    @Published var hasError = false
    
    func fetchUsers() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            
            let response = try await NetworkingManager.shared.request(.customer, type: UsersResponse.self)
            self.users = response.data
            
            
        } catch {
            self.hasError = true
            if let networkingError = error as? NetworkingManager.NetworkingError {
                self.error = networkingError
            } else {
                self.error = .custom(error: error)
            }
        }
        
    }
    
    
//    func fetchUsers(){
//        isLoading = true
//        NetworkingManager.shared.request(.customer, type: UsersResponse.self) { [weak self] res in
//            DispatchQueue.main.async {
//                defer { self?.isLoading = false }
//                switch res {
//                case .success(let response):
//                        self?.users = response.data
//                case .failure(let error):
//                    self?.hasError = true
//                    self?.error = error as? NetworkingManager.NetworkingError
//                }
//            }
//        }
//    }
}
