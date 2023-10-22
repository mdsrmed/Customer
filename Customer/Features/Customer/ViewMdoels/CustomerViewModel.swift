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
    @Published private(set) var viewState: ViewState?
    @Published var hasError = false
    
    private(set) var page = 1
    private(set) var totalPages: Int?
    
    private let networkingManager: NetworkingManagerImpl!
    
    var isLoading: Bool {
        viewState == .loading
    }
    
    var isFetching: Bool {
        viewState == .fetching
    }
    
    init(networkingManager: NetworkingManagerImpl = NetworkingManager.shared){
        self.networkingManager = networkingManager
    }
    
    func fetchUsers() async {
        reset()
        viewState = .loading
        defer { viewState = .finished }
        do {
            
            let response = try await networkingManager.request(session: .shared, .customer(page: page), type: UsersResponse.self)
            self.users = response.data
            self.totalPages = response.totalPages
            
            
        } catch {
            self.hasError = true
            if let networkingError = error as? NetworkingManager.NetworkingError {
                self.error = networkingError
            } else {
                self.error = .custom(error: error)
            }
        }
        
    }
    
    func hasReachedEnd(of user: User) -> Bool {
        users.last?.id == user.id
    }
    
    func fetchNextSetOfUsers() async {
        guard page != totalPages else {return}
        viewState = .fetching
        defer { viewState = .finished }
        page += 1
        
        do {
            let response = try await networkingManager.request(session: .shared, .customer(page: page), type: UsersResponse.self)
            self.users += response.data
            self.totalPages = response.totalPages
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

extension CustomerViewModel {
    enum ViewState {
        case fetching
        case loading
        case finished
    }
}

private extension CustomerViewModel {
    func reset() {
        if viewState == .finished {
            users.removeAll()
            
            page = 1
            totalPages = nil
            viewState = nil
        }
    }
}
