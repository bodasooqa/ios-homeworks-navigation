//
//  InfoView.swift
//  Navigation
//
//  Created by t.lolaev on 22.10.2021.
//

import UIKit

class InfoView: UIView {
    
    lazy var button: UIButton = {
        .createButton(title: "Show alert")
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 160),
            button.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
}
