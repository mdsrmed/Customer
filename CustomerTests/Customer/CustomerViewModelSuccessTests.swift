//
//  CustomerViewModelSuccessTests.swift
//  CustomerTests
//
//  Created by Md Shohidur Rahman on 10/21/23.
//

import XCTest
@testable import Customer

@MainActor
final class CustomerViewModelSuccessTests: XCTestCase {
    
    private var networkingMock: NetworkingManagerImpl!
    private var vm: CustomerViewModel!
    
   override  func setUp() {
        networkingMock = NetworkingManagerUserResponseSuccessMock()
        vm = CustomerViewModel(networkingManager: networkingMock)
    }
    
    
    override  func tearDown() {
        networkingMock = nil
        vm = nil
    }

    func test_with_successful_response_users_array_is_set() async throws {
        
        XCTAssertFalse(vm.isLoading,"The view model shouldn't be loading any data")
        defer {
            XCTAssertFalse(vm.isLoading,"The view model shouldn't be loading any data")
            XCTAssertEqual(vm.viewState, .finished, "The view model view state should be finished")
        }
        await vm.fetchUsers()
        XCTAssertEqual(vm.users.count, 6, "There should be 6 users with in our data array")
    }

}
