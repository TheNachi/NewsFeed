//
//  FeedViewController.swift
//  NewsFeed
//
//  Created by Munachimso Ugorji on 18/05/2021.
//

import UIKit

class FeedViewController: BaseViewController {
    @IBOutlet weak var feedTableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    private var viewModel: FeedViewModel?
    
    override func viewDidLoad() {
        self.spinner.transform = CGAffineTransform.init(scaleX: 2.5, y: 2.5)
        self.spinner.startAnimating()
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
    
    @IBAction func logOutButtonPressed(_ sender: UIButton) {
        AccountManager.shared.logOut()
        let logInVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "logInVC") as! LogInViewController
        self.present(logInVC, animated: true, completion: nil)
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
            self.spinner.stopAnimating()
            self.feedTableView.reloadData()
        }
    }
}
