//
//  FeedViewModel.swift
//  NewsFeed
//
//  Created by Munachimso Ugorji on 18/05/2021.
//

import Foundation

class FeedViewModel {
    private var feedService: FeedService?
    private var feedList: [GetFeedsQuery.Data.Feed] = []
    weak var delegate: FeedViewModelDelegate?
    private var trackCount = 0
    
    init(with feedService: FeedService?) {
        self.feedService = feedService
        self.feedService?.delegate = self
    }
    
    public func getFeed() {
        guard let feedService = self.feedService else { return }
        feedService.getFeeds()
    }
    
    public func updateFeedList(with response: [GetFeedsQuery.Data.Feed]) {
        self.feedList = response
    }
    
    public func getFeedListCount() -> Int {
        return self.feedList.count
    }
    
    public func getFeed(index: Int) -> GetFeedsQuery.Data.Feed {
        return self.feedList[index]
    }
    
    public func getFeedCellViewModel(index: Int) -> FeedCellViewModel {
        return FeedCellViewModel(with: self.getFeed(index: index))
    }
    
}

extension FeedViewModel: FeedsServiceDelegate {
    func onGetFeeds(response: [GetFeedsQuery.Data.Feed]) {
        if trackCount != response.count {
            self.updateFeedList(with: response)
            self.delegate?.onFeedLoaded()
            self.trackCount = response.count
        }
    }
    
    func onFail(error: String) {
        self.delegate?.onFail(error: error)
    }
}

protocol FeedViewModelDelegate: class {
    func onFeedLoaded()
    func onFail(error: String)
}
