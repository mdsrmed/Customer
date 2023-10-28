//
//  CreateViewModelSuccessTests.swift
//  CustomerTests
//
//  Created by Md Shohidur Rahman on 10/26/23.
//

import XCTest
@testable import Customer


@MainActor
final class CreateViewModelSuccessTests: XCTestCase {

    private var networkingMock: NetworkingManagerImpl!
    private var validattionMock: CreateValidatorImpl!
    private var vm: CreateViewModel!
    
    override  func setUp() {
        networkingMock = NetworkingManagerCreateSuccessMock()
        validattionMock = CreateValidatorSuccessMock()
        vm = CreateViewModel(networkingManager: networkingMock, validator: validattionMock)
    }
    
    override func tearDown() {
        networkingMock = nil
        validattionMock = nil
        vm = nil
    }
    
    
    func test_with_successful_response_submission_state_is_successful() async throws {
        XCTAssertNil(vm.state, "The view model state should be nil initially")
        defer {
            XCTAssertEqual(vm.state, .successful, "The view model state should be successful")
        }
        
        await vm.create()
    }
}
