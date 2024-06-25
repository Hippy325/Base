//
//  UIViewController+Extension.swift
//  SportsStates
//
//  Created by Тигран Гарибян on 02.06.2024.
//

import UIKit

extension UIViewController {
    func addTabBarSwiper() {
        let left = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeft))
        left.direction = .left
        self.view.addGestureRecognizer(left)

        let right = UISwipeGestureRecognizer(target: self, action: #selector(swipeRight))
        right.direction = .right
        self.view.addGestureRecognizer(right)
    }
    
    @objc func swipeLeft() {
        guard let tabBarController = tabBarController else { return }
        let total = tabBarController.viewControllers!.count - 1
        tabBarController.selectedIndex = min(total, tabBarController.selectedIndex + 1)

    }

    @objc func swipeRight() {
        guard let tabBarController = tabBarController else { return }
        tabBarController.selectedIndex = max(0, tabBarController.selectedIndex - 1)
    }
    
    func showAlert(_ alertTitle: String? = nil, andAlertMessage alertMessage: String? = nil) {
        let alertController = UIAlertController(title: alertTitle, message:
            alertMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func showAlert(_ alertTitle: String? = nil, andAlertMessage alertMessage: String? = nil, completion: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: alertTitle, message:
            alertMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: completion))
        present(alertController, animated: true, completion: nil)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func back() {
        navigationController?.popViewController(animated: true)
    }
}
