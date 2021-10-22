//
//  UIButtonExtension.swift
//  Navigation
//
//  Created by t.lolaev on 22.10.2021.
//

import UIKit

extension UIButton {
    
    class func createButton(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 6
        button.layer.shadowOpacity = 0.25
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.cornerRadius = 6
        return button
    }
    
}
