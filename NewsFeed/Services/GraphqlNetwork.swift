//
//  GraphqlNetwork.swift
//  NewsFeed
//
//  Created by Munachimso Ugorji on 18/05/2021.
//
import Foundation
import Apollo

class GraphqlNetwork {
    static let shared = GraphqlNetwork()
    
    private(set) lazy var apolloWithoutHeader = ApolloClient(url: URL(string: "http://localhost:4000/")!)

    
    private(set) lazy var apollo: ApolloClient = {
            let client = URLSessionClient()
            let cache = InMemoryNormalizedCache()
            let store = ApolloStore(cache: cache)
            let provider = NetworkInterceptorProvider(client: client, store: store)
            let url = URL(string: "http://localhost:4000/")!
            let transport = RequestChainNetworkTransport(interceptorProvider: provider,
                                                         endpointURL: url)
            return ApolloClient(networkTransport: transport, store: store)
        }()
}


class TokenAddingInterceptor: ApolloInterceptor {
    func interceptAsync<Operation: GraphQLOperation>(
        chain: RequestChain,
        request: HTTPRequest<Operation>,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void) {
        
        let token = "Bearer \(AccountManager.shared.getToken() ?? "")"
        request.addHeader(name: "Authorization", value: token)
        
        chain.proceedAsync(request: request,
                           response: response,
                           completion: completion)
    }
}

class NetworkInterceptorProvider: LegacyInterceptorProvider {
    override func interceptors<Operation: GraphQLOperation>(for operation: Operation) -> [ApolloInterceptor] {
        var interceptors = super.interceptors(for: operation)
        interceptors.insert(TokenAddingInterceptor(), at: 0)
        return interceptors
    }
}
