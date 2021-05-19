//
//  FeedTableViewCell.swift
//  NewsFeed
//
//  Created by Munachimso Ugorji on 18/05/2021.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    static let identifier = "feedCell"
    
    @IBOutlet weak var feedIdLabel: UILabel!
    @IBOutlet weak var feedDescriptionLabel: UILabel!
    @IBOutlet weak var feedUrlLabel: UILabel!
    @IBOutlet weak var feedVotesNameAndTimeLabel: UILabel!
    
    
    func bindViewModel(with viewModel: FeedCellViewModel) {
        self.feedIdLabel.text = viewModel.id
        self.feedDescriptionLabel.text = viewModel.description
        self.feedUrlLabel.text = viewModel.url
        self.feedVotesNameAndTimeLabel.text = viewModel.VotesNameAndTime
    }

}
