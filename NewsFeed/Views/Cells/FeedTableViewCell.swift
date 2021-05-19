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
    private var feedId: String?
    
    @IBAction func upVoteButtonPressed(_ sender: UIButton) {
        if let feedId = self.feedId, !AccountManager.shared.upVotedFeeds(id: feedId) {
            let upVoteService = UpVoteService()
            upVoteService.upVote(id: feedId)
            AccountManager.shared.upVoteFeed(id: feedId)
            self.upVoteButton.setImage(UIImage(named: "upVotingButtonIcon"), for: .normal)
            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (timer) in
                self.upVoteButton.setImage(UIImage(named: "upVotedButtonIcon"), for: .normal)
            }
        } else {
            print("already upvoted")
        }
        
    }
    
    func bindViewModel(with viewModel: FeedCellViewModel) {
        self.feedIdLabel.text = viewModel.id
        self.feedDescriptionLabel.text = viewModel.description
        self.feedUrlLabel.text = viewModel.url
        self.feedVotesNameAndTimeLabel.text = viewModel.VotesNameAndTime
        self.feedId = viewModel.id
        if let id = viewModel.id, AccountManager.shared.upVotedFeeds(id: id) {
            self.upVoteButton.setImage(UIImage(named: "upVotedButtonIcon"), for: .normal)
        } else {
            self.upVoteButton.setImage(UIImage(named: "upVoteButtonIcon"), for: .normal)
        }
    }

}
