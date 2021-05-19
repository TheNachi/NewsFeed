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
    weak var delegate: FeedCellDelegate?
    private var viewModel: FeedCellViewModel?
    
    @IBAction func upVoteButtonPressed(_ sender: UIButton) {
        if let feedId = viewModel?.id, !AccountManager.shared.upVotedFeeds(id: feedId) {
            let upVoteService = UpVoteService()
            upVoteService.upVote(id: feedId)
            AccountManager.shared.upVoteFeed(id: feedId)
            self.upVoteButton.setImage(UIImage(named: "upVotingButtonIcon"), for: .normal)
            self.feedVotesNameAndTimeLabel.text = viewModel?.updateCount()
            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (timer) in
                self.upVoteButton.setImage(UIImage(named: "upVotedButtonIcon"), for: .normal)
            }
        } else {
            delegate?.callDisplayAlert()
        }
        
    }
    
    func bindViewModel(with viewModel: FeedCellViewModel) {
        self.viewModel = viewModel
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

protocol FeedCellDelegate: class {
    func callDisplayAlert()
}
