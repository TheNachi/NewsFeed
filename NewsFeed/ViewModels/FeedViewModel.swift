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
    
    init(with feedService: FeedService?) {
        self.feedService = feedService
        self.feedService?.delegate = self
    }
    
    public func getFeed() {
        guard let feedService = self.feedService else { return }
        feedService.getFeeds()
    }
    
    private func updateFeedList(with response: [GetFeedsQuery.Data.Feed]) {
        self.feedList.append(contentsOf: response)
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
        self.updateFeedList(with: response)
        self.delegate?.onFeedLoaded()
    }
}

protocol FeedViewModelDelegate: class {
    func onFeedLoaded()
}
