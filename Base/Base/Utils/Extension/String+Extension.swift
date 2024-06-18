//
//  String+Extension.swift
//  SportsStates
//
//  Created by Тигран Гарибян on 30.05.2024.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, bundle: .main, comment:"")
    }
    
    func format(argument: String) -> String {
        return String(format: localized, argument.localized)
    }
}
