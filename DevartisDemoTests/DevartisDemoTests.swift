//
//  DevartisDemoTests.swift
//  DevartisDemoTests
//
//  Created by Diego Quimbo on 5/5/21.
//

import XCTest
@testable import DevartisDemo

class DevartisDemoTests: XCTestCase {

    var viewModel: RegisterViewModel!
    
    override func setUp() {
        viewModel = .init()
    }
    
    func testRegister() {
        let expectation = self.expectation(description: "Register service")
        
        viewModel.registerService(user: "DiegoYj", password: "12345") { success in
            XCTAssertEqual(success, true)
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 10, handler: nil)
    }
}

