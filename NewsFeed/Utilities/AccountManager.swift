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
        userDefaults.setValue(true, forKey: "IS_LOGGEDIN")
        userDefaults.synchronize()
    }
    
    func isLoggedIn() -> Bool {
        return userDefaults.bool(forKey: "IS_LOGGEDIN")
    }
    
    func logOut() {
        userDefaults.removeObject(forKey: "IS_LOGGEDIN")
    }
}
