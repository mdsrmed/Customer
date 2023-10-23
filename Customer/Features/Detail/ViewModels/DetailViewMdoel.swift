//
//  DetailViewMdoel.swift
//  Customer
//
//  Created by Md Shohidur Rahman on 9/16/23.
//

import Foundation

@MainActor
final class DetailViewModel: ObservableObject {
    
    @Published private(set) var userInfo: UserDetailResponse?
    @Published private(set) var error: NetworkingManager.NetworkingError?
    @Published private(set) var isLoading = false
    @Published var hasError = false
    
    
    private let networkingManager: NetworkingManagerImpl!
    
    init(networkingManager: NetworkingManagerImpl = NetworkingManager.shared){
        self.networkingManager = networkingManager
    }
    
    func fetchDetails(for id: Int) async {
        isLoading = true
        defer { isLoading = false }
        
        do {        
            self.userInfo = try await networkingManager.request(session: .shared, .detail(id: id), type: UserDetailResponse.self)
        } catch {
            self.hasError = true
            if let networkingError = error as? NetworkingManager.NetworkingError {
                self.error = networkingError
            } else {
                self.error = .custom(error: error)
            }
        }
    }
    
//    func fetchDetails(for id: Int){
//        isLoading = true
//        NetworkingManager.shared.request(.detail(id: id), type: UserDetailResponse.self) { [weak self] res in
//            DispatchQueue.main.async {
//                defer {self?.isLoading = false}
//                switch res {
//                case .success(let response):
//                        self?.userInfo = response
//                case .failure(let error):
//                    self?.hasError = true
//                    self?.error = error as? NetworkingManager.NetworkingError
//                }
//            }
//        }
//    }
}
