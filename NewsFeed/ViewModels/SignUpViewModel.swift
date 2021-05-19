//
//  SignUpViewModel.swift
//  NewsFeed
//
//  Created by Munachimso Ugorji on 19/05/2021.
//

import Foundation

class SignUpViewModel {
    private var signUpService: SignUpService?
    weak var delegate: SignUpViewModelDelegate?
    
    init(with signUpService: SignUpService?) {
        self.signUpService = signUpService
        self.signUpService?.delegate = self
    }
    
    public func validateFields(name: String, email: String, password: String) -> Bool {
        return !name.isEmpty && !email.isEmpty && !password.isEmpty
    }
    
    public func signUp(name: String, email: String, password: String) {
        guard let signUpService = self.signUpService else { return }
        signUpService.signUp(name: name, email: email, password: password)
    }
}

extension SignUpViewModel: SignUpServiceDelegate {
    func signUpSuccessful(result: SignUpMutation.Data.Signup) {
        if let token = result.token {
            AccountManager.shared.logIn(with: token)
            self.delegate?.signUpSuccessful()
        }
    }
    
    func onFail(error: String) {
        self.delegate?.onFail(error: error)
    }
}

protocol SignUpViewModelDelegate: class {
    func signUpSuccessful()
    func onFail(error: String)
}
