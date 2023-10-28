//
//  CreateViewModelValidationFailureTests.swift
//  CustomerTests
//
//  Created by Md Shohidur Rahman on 10/26/23.
//

import XCTest
@testable import Customer

@MainActor
final class CreateViewModelValidationFailureTests: XCTestCase {

    private var networkingMock: NetworkingManagerImpl!
    private var validattionMock: CreateValidatorImpl!
    private var vm: CreateViewModel!
    
    override  func setUp() {
        networkingMock = NetworkingManagerCreateSuccessMock()
        validattionMock = CreateValidatorFailureMock()
        vm = CreateViewModel(networkingManager: networkingMock, validator: validattionMock)
    }
    
    override func tearDown() {
        networkingMock = nil
        validattionMock = nil
        vm = nil
    }
    
    func test_with_invalid_form_submission_state_is_invalid() async {
        XCTAssertNil(vm.state, "The view model state should be nil initially")
        defer {
            XCTAssertEqual(vm.state, .unsuccessful, "The view model state should be unsuccessful")
        }
        
        await vm.create()
        
        XCTAssertTrue(vm.hasError, "The view model should have an error")
        XCTAssertNotNil(vm.error, "The view model error property shouldn't be nil")
        XCTAssertEqual(vm.error, .validation(error: CreateValidator.CreateValidatorError.invalidFirstName),
        "The view model error should be invalid first name")
    }
}
