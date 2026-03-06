//
//  Untitled.swift
//  TestNatife
//
//  Created by Nazar on 06.03.2026.
//

import UIKit

extension UIImageView {
    func loadImage(url: String) {
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error {
                print("Error: \(error)")
            }
            
            if let data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }.resume()
    }
}
