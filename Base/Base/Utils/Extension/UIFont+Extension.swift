//
//  UIFont+Extension.swift
//  SportsStates
//
//  Created by Тигран Гарибян on 29.05.2024.
//

import UIKit

extension UIFont {
    static func font(size: CGFloat, weight: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: UIFont.Weight(weight))
    }
}
