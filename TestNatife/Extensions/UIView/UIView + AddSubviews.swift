//
//  UIView + addSubviews.swift
//  TestNatife
//
//  Created by Nazar on 05.03.2026.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
