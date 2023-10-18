//
//  NetworkingEndpointTests.swift
//  CustomerTests
//
//  Created by Md Shohidur Rahman on 10/18/23.
//

import XCTest
@testable import Customer

final class NetworkingEndpointTests: XCTestCase {

    func test_with_customer_endpoint_request_is_valid(){
        let endpoint = Endpoint.customer(page: 1)
        
        XCTAssertEqual(endpoint.host, "reqres.in","The host should be reqres.in")
        XCTAssertEqual(endpoint.path,"/api/users", "The path should be /api/users")
        XCTAssertEqual(endpoint.methodType, .GET, "The method type should be GET")
        XCTAssertEqual(endpoint.queryItem, ["pag": "1"], "The query items should be page:1")
        
        XCTAssertEqual(endpoint.url?.absoluteString, "https://reqres.in/api/users?page=1&delay=3","The generated doesn't match out endpoint")
        
    }
    
    func test_with_detail_endpoint_request_is_valid(){
        
    }
    
    func test_with_create_endpoint_request_is_valid(){
        
    }

}
