//
//  FeedCellViewModel.swift
//  NewsFeed
//
//  Created by Munachimso Ugorji on 18/05/2021.
//

import Foundation
import UIKit

class FeedCellViewModel {
    let id: String?
    let description: String?
    let url: String?
    var VotesNameAndTime: String?
    var count: Int
    var dateString: String?
    var name: String?
    
    init(with model: GetFeedsQuery.Data.Feed) {
        self.id = model.id
        self.description = model.description
        self.url = model.url
        if let dateString = model.createdAt {
            self.dateString = dateString.toDate()?.relativeTime
            self.VotesNameAndTime = "\(model.votes) votes by \(model.postedBy?.name ?? "") \(self.dateString ?? "")"
        }
        self.name = model.postedBy?.name
        self.count = model.votes
    }
    
    func updateCount() -> String {
        self.count += 1
        return "\(self.count) votes by \(self.name ?? "") \(dateString ?? "")"
        
    }
}
