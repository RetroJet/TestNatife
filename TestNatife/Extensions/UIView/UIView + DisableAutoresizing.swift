//
//  UIView + AutoresizingMask.swift
//  TestNatife
//
//  Created by Nazar on 05.03.2026.
//

import UIKit

extension UIView {
    func disableAutoresizing(_ views: UIView...) {
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}
