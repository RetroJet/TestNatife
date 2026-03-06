
//
//  HomeViewModel.swift
//  TestNatife
//
//  Created by Nazar on 06.03.2026.
//

import Foundation

final class HomeViewModel {
    private(set) var posts: [Post] = []
    
    private let network = NetworkManager()
    
    var onPostsLoaded: (([Post]) -> Void)?
    
    func fetchPosts() {
        network.fetchPosts { [weak self] posts in
            self?.posts = posts
            self?.onPostsLoaded?(posts)
        }
    }
}
