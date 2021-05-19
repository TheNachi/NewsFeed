//
//  AccountManager.swift
//  NewsFeed
//
//  Created by Munachimso Ugorji on 19/05/2021.
//

import Foundation

struct AccountManager {
    static let shared = AccountManager()
    private let userDefaults = UserDefaults.standard
    
    func logIn(with token: String) {
        userDefaults.set(token, forKey: "USER_TOKEN")
        userDefaults.set(true, forKey: "IS_LOGGEDIN")
        userDefaults.synchronize()
    }
    
    func isLoggedIn() -> Bool {
        return userDefaults.bool(forKey: "IS_LOGGEDIN")
    }
    
    func logOut() {
        userDefaults.removeObject(forKey: "IS_LOGGEDIN")
        userDefaults.removeObject(forKey: "USER_TOKEN")
    }
    
    func upVotedFeeds(id: String) -> Bool{
        let upVotedFeeds : [String] = userDefaults.object(forKey: "UPVOTE_FEEDS") as? [String] ?? []
        return upVotedFeeds.contains(id)
    }
    
    func upVoteFeed(id: String) {
        var upVotedFeeds : [String] = userDefaults.object(forKey: "UPVOTE_FEEDS") as? [String] ?? []
        upVotedFeeds.append(id)
        userDefaults.set(upVotedFeeds, forKey: "UPVOTE_FEEDS")
    }
}
