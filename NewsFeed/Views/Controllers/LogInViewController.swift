//
//  LoginViewController.swift
//  NewsFeed
//
//  Created by Munachimso Ugorji on 18/05/2021.
//

import UIKit

class LogInViewController: BaseViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    private var viewModel: LogInViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModel()
        self.emailTextField.textContentType = .init(rawValue: "")
        self.passwordTextField.textContentType = .init(rawValue: "")
        self.spinner.transform = CGAffineTransform.init(scaleX: 2.5, y: 2.5)
    }
    
    func bindViewModel() {
        let logInService = LogInService()
        self.viewModel = LogInViewModel(with: logInService)
        viewModel?.delegate = self
    }
    
    @IBAction func logInButtonPressed(_ sender: UIButton) {
        guard let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              let vModel = self.viewModel
        else { return }
        
        if vModel.validateFields(email: email, password: password) {
            if Validator.emailIsValid(email: email) {
                self.spinner.startAnimating()
                self.logInButton.isHidden = true
                vModel.logIn(email: email, password: password)
            } else {
                self.displayAlert(title: "Error", message: "Ensure you entered a valid email")
            }
        } else {
            self.displayAlert(title: "Error", message: "All fields are required, please leave none empty")
        }
    }
}

extension LogInViewController: LogInViewModelDelegate {
    func logInSuccessful() {
        self.spinner.stopAnimating()
        let feedVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "feedVC") as! FeedViewController
        self.present(feedVC, animated: true, completion: nil)
    }
    
    func onFail(error: String?) {
        spinner.stopAnimating()
        self.logInButton.isHidden = false
        self.displayAlert(title: "Error", message: error)
    }
}
