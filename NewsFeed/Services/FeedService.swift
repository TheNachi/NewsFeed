//
//  FeedService.swift
//  NewsFeed
//
//  Created by Munachimso Ugorji on 18/05/2021.
//

import Foundation

struct FeedService {
    weak var delegate: FeedsServiceDelegate?
    
    func getFeeds() {
        GraphqlNetwork.shared.apolloWithoutHeader.fetch(query: GetFeedsQuery()) { result in
            switch result {
            case .success(let graphqlResult):
                guard let feedsList = graphqlResult.data?.feed else {
                    return }
                delegate?.onGetFeeds(response: feedsList)
            case .failure(let error):
                delegate?.onFail(error: error.localizedDescription)
            }
        }
    }
}

protocol FeedsServiceDelegate: class {
    func onGetFeeds(response: [GetFeedsQuery.Data.Feed])
    func onFail(error: String)
}
