//
//  LogInViewModelTests.swift
//  NewsFeedTests
//
//  Created by Munachimso Ugorji on 19/05/2021.
//

import XCTest
@testable import NewsFeed

class LogInViewModelTests: XCTestCase {

    let viewModel = LogInViewModel(with: nil)
    
    func testValidateFieldsForCorrectInfo() {
        let email = "muna@gmail.com",
            password = "12345"
        
        XCTAssertTrue(viewModel.validateFields(email: email, password: password))
    }
    
    func testValidateFieldsForinCorrectInfo() {
        let email = "",
            password = "12345"
        
        XCTAssertFalse(viewModel.validateFields(email: email, password: password))
    }

}
