//
//  SignUpService.swift
//  NewsFeed
//
//  Created by Munachimso Ugorji on 19/05/2021.
//

import Foundation

struct SignUpService {
    weak var delegate: SignUpServiceDelegate?
    
    func signUp(name: String, email: String, password: String) {
        GraphqlNetwork.shared.apolloWithoutHeader.perform(mutation: SignUpMutation(name: name, email: email, password: password)) { result in
            switch result {
            case .success(let graphqlResult):
                guard let userDetails = graphqlResult.data?.signup else {
                    delegate?.onFail(error: "error")
                    return
                }
                delegate?.signUpSuccessful(result: userDetails)
            case .failure(let error):
                delegate?.onFail(error: error.localizedDescription)
            }
        }
    }
}

protocol SignUpServiceDelegate: class {
    func signUpSuccessful(result: SignUpMutation.Data.Signup)
    func onFail(error: String)
}
