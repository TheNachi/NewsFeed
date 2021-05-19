//
//  PostViewModelTests.swift
//  NewsFeedTests
//
//  Created by Munachimso Ugorji on 19/05/2021.
//

import XCTest
@testable import NewsFeed

class PostViewModelTests: XCTestCase {

    let viewModel = PostViewModel(with: nil)
    
    func testValidateFieldsForCorrectInfo() {
        let url = "www.google.com",
            description = "world famous search engine"
        
        XCTAssertTrue(viewModel.validateFields(url: url, description: description))
    }
    
    func testValidateFieldsForinCorrectInfo() {
        let url = "www.google.com",
            description = ""
        
        XCTAssertFalse(viewModel.validateFields(url: url, description: description))
    }

}
