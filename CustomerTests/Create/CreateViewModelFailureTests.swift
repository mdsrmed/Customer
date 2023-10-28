//
//  CreateViewModelFailureTests.swift
//  CustomerTests
//
//  Created by Md Shohidur Rahman on 10/26/23.
//

import XCTest
@testable import Customer

@MainActor
final class CreateViewModelFailureTests: XCTestCase {

    private var networkingMock: NetworkingManagerImpl!
    private var validattionMock: CreateValidatorImpl!
    private var vm: CreateViewModel!
    
    override  func setUp() {
        networkingMock = NetworkingManagerCreateFailureMock()
        validattionMock = CreateValidatorSuccessMock()
        vm = CreateViewModel(networkingManager: networkingMock, validator: validattionMock)
    }
    
    override func tearDown() {
        networkingMock = nil
        validattionMock = nil
        vm = nil
    }
    
    func test_with_unsuccessful_response_submission_state_is_unsuccessful() async throws {
        XCTAssertNil(vm.state, "The view model state should be nil initially")
        defer {
            XCTAssertEqual(vm.state, .unsuccessful, "The view model state should be unsuccessful")
        }
        
        await vm.create()
        
        XCTAssertTrue(vm.hasError, "The view model should have an error")
        XCTAssertNotNil(vm.error, "The view model error shouldn't be nil")
        XCTAssertEqual(vm.error, .networking(error: NetworkingManager.NetworkingError.invalidURL), "The view model error should be a networking error with an invalid url")
    }

}
