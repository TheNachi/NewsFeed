//
//  UpVoteService.swift
//  NewsFeed
//
//  Created by Munachimso Ugorji on 19/05/2021.
//

import Foundation

struct UpVoteService {
    
    func upVote(id: String) {
        GraphqlNetwork.shared.apolloWithoutHeader.perform(mutation: UpVoteMutation(id: id)) {
            result in
            switch result {
            case .success( _):
                print("Success")
            case.failure(let error):
                print(error, "the error")
            }
        }
    }
}
