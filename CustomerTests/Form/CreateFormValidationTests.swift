//
//  CreateFormValidationTests.swift
//  CustomerTests
//
//  Created by Md Shohidur Rahman on 10/13/23.
//

import XCTest
@testable import Customer

final class CreateFormValidationTests: XCTestCase {
    
    private var validator: CreateValidator!
    
    override func setUp()  {
        validator = CreateValidator()
    }
    
    override func tearDown() {
        validator = nil
    }
    
    

    func test_with_empty_person_first_name_error_thrown(){
        let customer = NewCustomer()
//        let validator = CreateValidator()
        
        XCTAssertThrowsError(try validator.validate(customer),"Error for an empty first name should be thrown")
        
        do{
            _ = try validator.validate(customer)
        } catch {
            guard let validationError = error as? CreateValidator.CreateValidatorError else {
                XCTFail("Got the wrong type of error expecting a create validator error")
                return
            }
            
            XCTAssertEqual(validationError, CreateValidator.CreateValidatorError.invalidFirstName, "Expecting an error where we have an invalid first name")
        }
    }
    
    func test_with_empty_first_name_error_thrown(){
        let customer = NewCustomer(lastName: "Ads",job: "iOS Dev")
        XCTAssertThrowsError(try validator.validate(customer),"Error for an empty first name should be thrown")
        
        do{
            _ = try validator.validate(customer)
        } catch {
            guard let validationError = error as? CreateValidator.CreateValidatorError else {
                XCTFail("Got the wrong type of error expecting a create validator error")
                return
            }
            
            XCTAssertEqual(validationError, CreateValidator.CreateValidatorError.invalidFirstName, "Expecting an error where we have an invalid first name")
        }
    }
    
    func test_with_empty_last_name_error_thrown(){
        let customer = NewCustomer(firstName: "Shohid", job: "iOS Dev")
        XCTAssertThrowsError(try validator.validate(customer),"Error for an empty last name should be thrown")
        
        do{
            _ = try validator.validate(customer)
        } catch {
            guard let validationError = error as? CreateValidator.CreateValidatorError else {
                XCTFail("Got the wrong type of error expecting a create validator error")
                return
            }
            
            XCTAssertEqual(validationError, CreateValidator.CreateValidatorError.invalidLastName, "Expecting an error where we have an invalid last name")
        }
        
    }
    
    func test_with_empty_job_error_thrown(){
        let customer = NewCustomer(firstName: "Md",lastName: "Rahman")
        XCTAssertThrowsError(try validator.validate(customer),"Error for an empty job should be thrown")
        
        do{
            _ = try validator.validate(customer)
        } catch {
            guard let validationError = error as? CreateValidator.CreateValidatorError else {
                XCTFail("Got the wrong type of error expecting a create validator error")
                return
            }
            
            XCTAssertEqual(validationError, CreateValidator.CreateValidatorError.invalidJob, "Expecting an error where we have an invalid job")
        }
        
        
    }
    
    func test_with_valid_person_error_not_thrown(){
       let customer = NewCustomer(firstName: "Md", lastName: "Rahman", job: "iOS Dev")
        
        do{
            _ = try validator.validate(customer)
        } catch {
            XCTFail("No error should be thrown,since the customer should be a valid object")
        }
    }

}
