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
        super.viewDidLoad()
        self.spinner.transform = CGAffineTransform.init(scaleX: 2.5, y: 2.5)
        self.spinner.startAnimating()
        self.feedTableView.delegate = self
        self.feedTableView.dataSource = self
        self.feedTableView.tableFooterView = UIView()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.bindViewModel()
    }
    
    @IBAction func makePostButtonPressed(_ sender: UIButton) {
//        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let postVC = storyboard.instantiateViewController(identifier: "postVC") as! PostViewController
//        self.modalPresentationStyle = .overFullScreen
//        self.present(postVC, animated: true, completion: nil)
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
            feedCell.delegate = self
            return feedCell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let vModel = viewModel else { return }
        if let lastVisibleIndexPath = tableView.indexPathsForVisibleRows?.last {
            if indexPath == lastVisibleIndexPath && indexPath.row == vModel.getFeedListCount() - 1 {
                vModel.getFeed()
            }
        }
    }
}

extension FeedViewController: FeedViewModelDelegate {
    func onFeedLoaded() {
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
            self.feedTableView.reloadData()
        }
    }
    
    func onFail(error: String) {
        let alertAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.viewModel?.getFeed()
        }
        self.displayAlert(title: "Error", message: "There was a problem loading data from the internet, ensure you're connected to the internet", actions: [alertAction], preferredStyle: .alert)
    }
}


extension FeedViewController: FeedCellDelegate {
    func callDisplayAlert() {
        self.displayAlert(title: "Error", message: "You've already upvoted this feed")
    }
}
