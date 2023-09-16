//
//  CustomerViewModel.swift
//  Customer
//
//  Created by Md Shohidur Rahman on 9/16/23.
//

import Foundation




final class CustomerViewModel: ObservableObject {
    
    @Published private(set) var users: [User] = []
    
    func fetchUsers(){
        NetworkingManager.shared.request("https://reqres.in/api/users", type: UsersResponse.self) { [weak self] res in
            DispatchQueue.main.async {
                switch res {
                case .success(let response):
                        self?.users = response.data
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
