//
//  ViewController.swift
//  NewsFeed
//
//  Created by Munachimso Ugorji on 17/05/2021.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    private var viewModel: SignUpViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModel()
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
                vModel.signUp(name: name, email: email, password: password)
            } else {
                print("email not valid")
            }
        } else {
            print("ensure no field is vacant")
        }
    }
}

extension SignUpViewController: SignUpViewModelDelegate {
    func signUpSuccessful() {
        let feedVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "feedVC") as! FeedViewController
        self.present(feedVC, animated: true, completion: nil)
    }
}
