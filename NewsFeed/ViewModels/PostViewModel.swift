//
//  PostViewModel.swift
//  NewsFeed
//
//  Created by Munachimso Ugorji on 19/05/2021.
//

import Foundation

class PostViewModel {
    private var postService: PostService?
    weak var delegate: PostViewModelDelegate?
    
    init(with postService: PostService?) {
        self.postService = postService
        self.postService?.delegate = self
    }
    
    public func validateFields(url: String, description: String) -> Bool {
        return !url.isEmpty && !description.isEmpty
    }
    
    public func post(url: String, description: String) {
        guard let postService = self.postService else { return }
        postService.post(url: url, description: description)
    }
}

extension PostViewModel: PostServiceDelegate {
    func postSuccessful() {
        delegate?.postSuccessful()
    }
}

protocol PostViewModelDelegate: class {
    func postSuccessful()
}
