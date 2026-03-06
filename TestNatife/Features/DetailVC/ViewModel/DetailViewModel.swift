//
//  DetailViewModel.swift
//  TestNatife
//
//  Created by Nazar on 06.03.2026.
//

import Foundation

final class DetailViewModel {
    private let network = NetworkManager()
    
    var onPostLoaded: ((PostDetail) -> Void)?
    
    func fetchPost(id: Int) {
        network.fetchPost(id: id) { [weak self] post in
            if let post {
                self?.onPostLoaded?(post)
            }
        }
    }
}
