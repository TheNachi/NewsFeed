//
//  LogInViewModel.swift
//  NewsFeed
//
//  Created by Munachimso Ugorji on 19/05/2021.
//

import Foundation

class LogInViewModel {
    private var logInService: LogInService?
    weak var delegate: LogInViewModelDelegate?
    
    init(with logInService: LogInService?) {
        self.logInService = logInService
        self.logInService?.delegate = self
    }
    
    public func validateFields(email: String, password: String) -> Bool {
        return !email.isEmpty && !password.isEmpty
    }
    
    public func logIn(email: String, password: String) {
        guard let logInService = self.logInService else { return }
        logInService.logIn(email: email, password: password)
    }
}

extension LogInViewModel: LoginServiceDelegate {
    func logInSuccessful(result: LogInMutation.Data.Login) {
        if let token = result.token {
            AccountManager.shared.logIn(with: token)
            self.delegate?.logInSuccessful()
        }
    }
    
    func onFail(error: String?) {
        self.delegate?.onFail(error: error)
    }
}

protocol LogInViewModelDelegate: class {
    func logInSuccessful()
    func onFail(error: String?)
}
