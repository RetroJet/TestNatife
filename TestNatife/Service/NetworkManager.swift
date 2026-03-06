//
//  NetworkManager.swift
//  TestNatife
//
//  Created by Nazar on 06.03.2026.
//

import Foundation

final class NetworkManager {
    private let url = "https://raw.githubusercontent.com/anton-natife/jsons/master/api"
    
    //Get posts
    func fetchPosts(completion: @escaping ([Post]) -> Void) {
        guard let url = URL(string: "\(url)/main.json") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error {
                print("Error: \(error)")
                return
            }
            
            guard let data else { return }
            
            let responce = try? JSONDecoder().decode(PostList.self, from: data)
            
            DispatchQueue.main.async {
                completion(responce?.posts ?? [])
            }
        }.resume()
    }
    
    //Get post
    func fetchPost(id: Int, completion: @escaping (PostDetail?) -> Void) {
        guard let url = URL(string: "\(url)/posts/\(id).json") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error {
                print("Error: \(error)")
                return
            }
            
            guard let data else { return }
            
            let response = try? JSONDecoder().decode(PostDetailList.self, from: data)
            
            DispatchQueue.main.async {
                completion(response?.post)
            }
        }.resume()
    }
}
