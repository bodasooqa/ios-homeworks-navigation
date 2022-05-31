//
//  InfoView.swift
//  Navigation
//
//  Created by t.lolaev on 22.10.2021.
//

import UIKit

class InfoView: UIView {
    
    public var button: UIButton?
    
    lazy var label: UILabel = {
        label = UILabel()
        return label
    }()
    
    lazy var planetTitleLabel: UILabel = {
        planetTitleLabel = UILabel()
        return planetTitleLabel
    }()
    
    var subViews: [UIView] {
        [label, planetTitleLabel]
    }
    
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
            
            subViews.forEach {
                addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
            
            NSLayoutConstraint.activate([
                button.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                button.topAnchor.constraint(equalTo: self.topAnchor, constant: 100),
                button.widthAnchor.constraint(equalToConstant: 160),
                button.heightAnchor.constraint(equalToConstant: 40),
                
                label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                label.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 20),
                
                planetTitleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                planetTitleLabel.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10),
            ])
        }
    }
    
    public func configureTableView(_ tableView: UITableView) {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: self.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: self.rightAnchor),
            tableView.topAnchor.constraint(equalTo: planetTitleLabel.bottomAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
    }
    
}
