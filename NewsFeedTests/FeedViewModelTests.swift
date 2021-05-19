//
//  FeedViewModelTests.swift
//  NewsFeedTests
//
//  Created by Munachimso Ugorji on 19/05/2021.
//

import XCTest
@testable import NewsFeed

class FeedViewModelTests: XCTestCase {
    let feedList = [
        GetFeedsQuery.Data.Feed(id: "1", description: "A description", url: "the url", votes: 20),
        GetFeedsQuery.Data.Feed(id: "2", description: "A description and aother", url: "url", votes: 204),
        GetFeedsQuery.Data.Feed(id: "3", description: "Another", url: "a url", votes: 240),
        GetFeedsQuery.Data.Feed(id: "4", description: "A description", url: "my url", votes: 60)
    ]
    let viewModel = FeedViewModel(with: nil)

    func testGetFeedListCount() {
        viewModel.updateFeedList(with: feedList)
        let count = viewModel.getFeedListCount()
        
        XCTAssertEqual(count, feedList.count)
    }
    
    func testEmptyFeedListCount() {
        let count = viewModel.getFeedListCount()
        
        XCTAssertEqual(count, 0)
    }
    
    func testGetFeed() {
        viewModel.updateFeedList(with: feedList)
        let feed1 = viewModel.getFeed(index: 0),
            feed2 = viewModel.getFeed(index: 1),
            feed3 = viewModel.getFeed(index: 2),
            feed4 = viewModel.getFeed(index: 3)
        
        XCTAssertEqual(feed1.id, feedList[0].id)
        XCTAssertEqual(feed2.id, feedList[1].id)
        XCTAssertEqual(feed3.id, feedList[2].id)
        XCTAssertEqual(feed4.id, feedList[3].id)
    }
    
    func testGetFeedCellViewModel() {
        viewModel.updateFeedList(with: feedList)
        let feedCellVM = viewModel.getFeedCellViewModel(index: 0)
        
        XCTAssertEqual(feedCellVM.description, feedList[0].description)
        XCTAssertEqual(feedCellVM.id, feedList[0].id)
        XCTAssertEqual(feedCellVM.url, feedList[0].url)
    }
}
