//
//  JSONMapperTests.swift
//  CustomerTests
//
//  Created by Md Shohidur Rahman on 10/9/23.
//

import Foundation
import XCTest
@testable import Customer

class JSONMapperTests: XCTestCase {
    
    
    func test_with_valid_json_error_thrown(){
        XCTAssertNoThrow(try StaticJSONMapper.decode(file: "UsersStaticData", type: UsersResponse.self), "Mapper shouldn't throw an error")
        
        
        let userResponse = try? StaticJSONMapper.decode(file: "UsersStaticData", type: UsersResponse.self)
        XCTAssertNotNil(userResponse,"User response shouldn't be nil")
        
        XCTAssertEqual(userResponse?.page, 1, "Page number should be 1")
        XCTAssertEqual(userResponse?.perPage, 6, "Page number should be 6")
        XCTAssertEqual(userResponse?.total, 12, "Total should be 12")
        XCTAssertEqual(userResponse?.totalPages, 2, "Total pages should be 2")
        
        
        XCTAssertEqual(userResponse?.data.count, 6, "Total number of users should be 6")
        XCTAssertEqual(userResponse?.data[0].id, 1, "The id should be 1")
        XCTAssertEqual(userResponse?.data[0].email, "george.bluth@reqres.in", "The email should be george.bluth@reqres.in")
        XCTAssertEqual(userResponse?.data[0].firstName, "George", "The first name should be George")
        XCTAssertEqual(userResponse?.data[0].lastName, "Bluth", "The last name should be Bluth")
        XCTAssertEqual(userResponse?.data[0].avatar, "https://reqres.in/img/faces/1-image.jpg", "The url should be https://reqres.in/img/faces/1-image.jpg")
        
    }
    
    func test_with_missing_file_error_thrown(){
        
        XCTAssertThrowsError(try StaticJSONMapper.decode(file: "", type: UsersResponse.self), "An error should be thrown")
        
        do{
            _ = try StaticJSONMapper.decode(file: "", type: UsersResponse.self)
            
        } catch {
            guard let mappingError = error as? StaticJSONMapper.MappingError else {
                XCTFail("This is the wrong type of error for missing files")
                return
            }
            
            XCTAssertEqual(mappingError, StaticJSONMapper.MappingError.failedToGetContents,"This should be a failed to get contents error")
        }
    }
    
    func test_with_invalid_file_error_thrown(){
        
        XCTAssertThrowsError(try StaticJSONMapper.decode(file: "", type: UsersResponse.self), "An error should be thrown")
        
        do{
            _ = try StaticJSONMapper.decode(file: "apple", type: UsersResponse.self)
            
        } catch {
            guard let mappingError = error as? StaticJSONMapper.MappingError else {
                XCTFail("This is the wrong type of error for missing files")
                return
            }
            
            XCTAssertEqual(mappingError, StaticJSONMapper.MappingError.failedToGetContents,"This should be a failed to get contents error")
        }
    }
    
    func test_with_invalid_json_error_thrown(){
        
        XCTAssertThrowsError(try StaticJSONMapper.decode(file: "UsersStaticData", type: UserDetailResponse.self), "An error should be thrown")
        
        do{
            _ = try StaticJSONMapper.decode(file: "UsersStaticData", type: UserDetailResponse.self)
            
        } catch {
            if error is StaticJSONMapper.MappingError {
                XCTFail("Got the wrong type of error,expecting a system decoding error")
            }
        }
    }
}
