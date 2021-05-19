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
    
    @IBOutlet weak var upVoteButton: UIButton!
    
    override func layoutSubviews() {

    }
    
    @IBAction func upVoteButtonPressed(_ sender: UIButton) {
        self.upVoteButton.setImage(UIImage(named: "upVotingButtonIcon"), for: .normal)
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (timer) in
            self.upVoteButton.setImage(UIImage(named: "upVotedButtonIcon"), for: .normal)
        }
    }
    
    func bindViewModel(with viewModel: FeedCellViewModel) {
        self.feedIdLabel.text = viewModel.id
        self.feedDescriptionLabel.text = viewModel.description
        self.feedUrlLabel.text = viewModel.url
        self.feedVotesNameAndTimeLabel.text = viewModel.VotesNameAndTime
        if let id = viewModel.id, AccountManager.shared.upVotedFeeds(id: id) {
            self.upVoteButton.setImage(UIImage(named: "upVotedButtonIcon"), for: .normal)
        } else {
            self.upVoteButton.setImage(UIImage(named: "upVoteButtonIcon"), for: .normal)
        }
    }

}
