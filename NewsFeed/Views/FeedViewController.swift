//
//  FeedViewController.swift
//  NewsFeed
//
//  Created by Munachimso Ugorji on 18/05/2021.
//

import UIKit

class FeedViewController: UIViewController {
    @IBOutlet weak var feedTableView: UITableView!
    private var viewModel: FeedViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.feedTableView.delegate = self
        self.feedTableView.dataSource = self
        self.bindViewModel()
        self.feedTableView.tableFooterView = UIView()
    }
    
    func bindViewModel() {
        let feedService = FeedService()
        viewModel = FeedViewModel(with: feedService)
        viewModel?.delegate = self
        viewModel?.getFeed()
    }
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let vModel = viewModel else { return 0 }
        return vModel.getFeedListCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let vModel = viewModel else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.identifier, for: indexPath)
        
        if let feedCell = cell as? FeedTableViewCell {
            feedCell.bindViewModel(with: vModel.getFeedCellViewModel(index: indexPath.row))
            return feedCell
        }
        
        return cell
    }
}

extension FeedViewController: FeedViewModelDelegate {
    func onFeedLoaded() {
        DispatchQueue.main.async {
            self.feedTableView.reloadData()
        }
    }
}
