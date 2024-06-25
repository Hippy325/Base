//
//  UIView+Extension.swift
//  Base
//
//  Created by Тигран Гарибян on 21.06.2024.
//

import UIKit

extension UIView {
    func addSubview(
        _ view: UIView,
        top: CGFloat = 0,
        bottom: CGFloat = 0,
        left: CGFloat = 0,
        right: CGFloat = 0
    ) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor, constant: top),
            view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: bottom),
            view.leftAnchor.constraint(equalTo: leftAnchor, constant: left),
            view.rightAnchor.constraint(equalTo: rightAnchor, constant: right),
        ])
    }
}
