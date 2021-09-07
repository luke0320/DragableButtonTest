//
//  UIView+autolayout.swift
//  ButtonLayout
//
//  Created by Luke on 2021/9/7.
//

import UIKit

extension UIView {
    func fillSuperview(insets: UIEdgeInsets = .zero) {
        guard let superview = superview else {
            fatalError("Superview not exist")
        }
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor, constant: insets.left),
            trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor, constant: -insets.right),
            topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor, constant: insets.top),
            bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor, constant: insets.bottom)
        ])
    }
}
