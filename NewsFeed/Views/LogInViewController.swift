//
//  LoginViewController.swift
//  NewsFeed
//
//  Created by Munachimso Ugorji on 18/05/2021.
//

import UIKit

class LogInViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    private var viewModel: LogInViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
                vModel.logIn(email: email, password: password)
            } else {
                print("email not valid")
            }
        } else {
            print("Ensure no field is vacant")
        }
    }
}

extension LogInViewController: LogInViewModelDelegate {
    func logInSuccessful() {
        let feedVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "feedVC") as! FeedViewController
        self.present(feedVC, animated: true, completion: nil)
    }
}
