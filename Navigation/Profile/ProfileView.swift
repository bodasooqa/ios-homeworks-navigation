//
//  View.swift
//  Navigation
//
//  Created by t.lolaev on 22.10.2021.
//

import UIKit

class ProfileView: UIView {
    
    lazy var label: UILabel = {
        label = UILabel(frame: .zero)
        label.text = "Hi there!"
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
}
