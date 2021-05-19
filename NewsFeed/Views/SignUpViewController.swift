//
//  ViewController.swift
//  NewsFeed
//
//  Created by Munachimso Ugorji on 17/05/2021.
//

import UIKit

class SignUpViewController: BaseViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var signUpButton: UIButton!
    private var viewModel: SignUpViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModel()
        self.spinner.transform = CGAffineTransform.init(scaleX: 2.5, y: 2.5)
        self.nameTextField.textContentType = .init(rawValue: "")
        self.emailTextField.textContentType = .init(rawValue: "")
        self.passwordTextField.textContentType = .init(rawValue: "")
    }
    
    func bindViewModel() {
        let signUpService = SignUpService()
        self.viewModel = SignUpViewModel(with: signUpService)
        viewModel?.delegate = self
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        guard let name = nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              let vModel = self.viewModel
        else { return }
        
        
        if vModel.validateFields(name: name, email: email, password: password){
            if Validator.emailIsValid(email: email) {
                spinner.startAnimating()
                self.signUpButton.isHidden = true
                vModel.signUp(name: name, email: email, password: password)
            } else {
                self.displayAlert(title: "Error", message: "Ensure you entered a valid email")
            }
        } else {
            self.displayAlert(title: "Error", message: "All fields are required, please leave none empty")
        }
    }
}

extension SignUpViewController: SignUpViewModelDelegate {
    func signUpSuccessful() {
        spinner.stopAnimating()
        let feedVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "feedVC") as! FeedViewController
        self.present(feedVC, animated: true, completion: nil)
    }
}
