//
//  InfoView.swift
//  Navigation
//
//  Created by t.lolaev on 22.10.2021.
//

import UIKit

class InfoView: UIView {
    
    public var button: UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureLayout() {
        if let button = button {
            addSubview(button)
            button.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                button.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                button.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                button.widthAnchor.constraint(equalToConstant: 160),
                button.heightAnchor.constraint(equalToConstant: 40)
            ])
        }
    }
    
}
