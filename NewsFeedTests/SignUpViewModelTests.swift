//
//  SignUpViewModelTests.swift
//  NewsFeedTests
//
//  Created by Munachimso Ugorji on 19/05/2021.
//

import XCTest
@testable import NewsFeed

class SignUpViewModelTests: XCTestCase {

    let viewModel = SignUpViewModel(with: nil)
    
    func testValidateFieldsForCorrectInfo() {
        let email = "muna@gmail.com",
            name = "muna",
            password = "12345"
        
        XCTAssertTrue(viewModel.validateFields(name: name, email: email, password: password))
    }
    
    func testValidateFieldsForinCorrectInfo() {
        let email = "",
            name = "muna",
            password = "12345"
        
        XCTAssertFalse(viewModel.validateFields(name: name, email: email, password: password))
    }

}
