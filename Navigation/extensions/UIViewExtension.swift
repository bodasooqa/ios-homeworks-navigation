//
//  UIViewExtension.swift
//  Navigation
//
//  Created by t.lolaev on 23.10.2021.
//

import UIKit

extension UIView {
    func putIntoSafeArea(view: UIView, height: CGFloat? = nil) {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            self.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
        ])
        
        if let heightConstant = height {
            self.heightAnchor.constraint(equalToConstant: heightConstant).isActive = true
        } else {
            self.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor).isActive = true
        }
    }
}
