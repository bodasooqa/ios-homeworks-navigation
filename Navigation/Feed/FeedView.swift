//
//  FeedView.swift
//  Navigation
//
//  Created by t.lolaev on 22.10.2021.
//

import UIKit

class FeedView: UIView {
    
    var button1: UIButton?
    
    var button2: UIButton?
    
    lazy var stackView: UIStackView = {
        UIStackView()
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(stackView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureStackView() {
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 16),
            stackView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -16),
            stackView.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 100),
        ])
        
        if let button1 = button1, let button2 = button2 {
            stackView.addArrangedSubview(button1)
            stackView.addArrangedSubview(button2)
        }
        
    }
    
}
