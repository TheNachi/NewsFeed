//
//  PostService.swift
//  NewsFeed
//
//  Created by Munachimso Ugorji on 19/05/2021.
//

import Foundation

struct PostService {
    weak var delegate: PostServiceDelegate?
    
    func post(url: String, description: String) {
        GraphqlNetwork.shared.apollo.perform(mutation: PostMutation(url: url, description: description)) {
            result in
            switch result {
            case .success( _):
                delegate?.postSuccessful()
            case.failure(let error):
                delegate?.onFail(error: error.localizedDescription)
            }
        }
    }
}

protocol PostServiceDelegate: class {
    func postSuccessful()
    func onFail(error: String)
}
