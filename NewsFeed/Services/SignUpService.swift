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
        GraphqlNetwork.shared.apollo.perform(mutation: SignUpMutation(name: name, email: email, password: password)) { result in
            switch result {
            case .success(let graphqlResult):
                guard let userDetails = graphqlResult.data?.signup else {
                    print("error")
                    return
                }
                delegate?.signUpSuccessful(result: userDetails)
            case .failure(let error):
                print(error, "the error")
            }
        }
    }
}

protocol SignUpServiceDelegate: class {
    func signUpSuccessful(result: SignUpMutation.Data.Signup)
}
