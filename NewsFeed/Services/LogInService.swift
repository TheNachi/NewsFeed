//
//  LogInService.swift
//  NewsFeed
//
//  Created by Munachimso Ugorji on 19/05/2021.
//

import Foundation

struct LogInService {
    weak var delegate: LoginServiceDelegate?
    
    func logIn(email: String, password: String) {
        GraphqlNetwork.shared.apolloWithoutHeader.perform(mutation: LogInMutation(email: email, password: password)) { result in
            switch result {
            case .success(let graphqlResult):
                guard let userDetails = graphqlResult.data?.login else {
                    print("error")
                    return
                }
                delegate?.logInSuccessful(result: userDetails)
            case .failure(let error):
                print(error, "the error")
            }
            
        }
    }
}

protocol LoginServiceDelegate: class {
    func logInSuccessful(result: LogInMutation.Data.Login)
}
