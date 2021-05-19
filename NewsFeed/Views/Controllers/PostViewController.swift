//
//  PostViewController.swift
//  NewsFeed
//
//  Created by Munachimso Ugorji on 19/05/2021.
//

import UIKit

class PostViewController: BaseViewController {
    
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    private var viewModel: PostViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.urlTextField.textContentType = .init(rawValue: "")
        self.titleTextField.textContentType = .init(rawValue: "")
        self.bindViewModel()
    }
    
    func bindViewModel() {
        let postService = PostService()
        self.viewModel = PostViewModel(with: postService)
        viewModel?.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        urlTextField.becomeFirstResponder()
    }
    
    @IBAction func postButtonPressed(_ sender: UIButton) {
        guard let url = urlTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              let description = titleTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              let vModel = self.viewModel
        else { return }
        
        if vModel.validateFields(url: url, description: description) {
            vModel.post(url: url, description: description)
        } else {
            self.displayAlert(title: "Error", message: "All fields are required, please leave none empty")
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension PostViewController: PostViewModelDelegate {
    func postSuccessful() {
        let alertAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.dismiss(animated: true, completion: nil)
        }
        self.displayAlert(title: "Success", message: "You've successful created a post", actions: [alertAction], preferredStyle: .alert)
    }
    
    func onFail(error: String) {
        self.displayAlert(title: "Error", message: "There was a problem posting your feed, please try again")
    }
}
