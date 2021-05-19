//
//  GraphqlNetwork.swift
//  NewsFeed
//
//  Created by Munachimso Ugorji on 18/05/2021.
//

import Apollo

class GraphqlNetwork {
    static let shared = GraphqlNetwork()
    
    private(set) lazy var apollo = ApolloClient(url: URL(string: "http://localhost:4000/")!)
}
