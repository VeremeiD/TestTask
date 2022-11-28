//
//  UIViewController+Extensions.swift
//  TestTask
//
//  Created by Dmitriy Veremei on 28.11.22.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTapped() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
