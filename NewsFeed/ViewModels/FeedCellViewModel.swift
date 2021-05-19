//
//  FeedCellViewModel.swift
//  NewsFeed
//
//  Created by Munachimso Ugorji on 18/05/2021.
//

import Foundation

struct FeedCellViewModel {
    let id: String?
    let description: String?
    let url: String?
    let VotesNameAndTime: String?
    
    init(with model: GetFeedsQuery.Data.Feed) {
        self.id = model.id
        self.description = model.description
        self.url = model.url
        self.VotesNameAndTime = "\(model.votes) votes by \(model.postedBy?.name ?? "")"
    }
}
