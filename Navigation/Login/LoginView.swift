//
//  LoginView.swift
//  Navigation
//
//  Created by t.lolaev on 01.11.2021.
//

import UIKit

class LoginView: UIView {
    
    private let logoSize = 100
    
    lazy var logo: UIImageView = {
        let image = UIImage(named: "Logo")
        logo = UIImageView(image: image)
        logo.frame = CGRect(x: 0, y: 0, width: logoSize, height: logoSize)
        
        return logo
    }()
    
    lazy var scrollView: UIScrollView = {
        scrollView = UIScrollView()
        return scrollView
    }()
    
    lazy var stackView: UIStackView = {
        stackView = UIStackView()
        stackView.layer.cornerRadius = 10
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.layer.borderWidth = 0.5
        stackView.backgroundColor = .systemGray6
        
        return stackView
    }()
    
    lazy var loginInput: UITextField = {
        loginInput = CustomTextField()
        loginInput.placeholder = "Email or phone"
        loginInput.textColor = .black
        loginInput.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        loginInput.tintColor = UIColor(named: "AccentColor")
        loginInput.autocapitalizationType = .none
        loginInput.layer.borderWidth = 0.5
        loginInput.layer.borderColor = UIColor.lightGray.cgColor
        
        return loginInput
    }()
    
    lazy var passwordInput: UITextField = {
        passwordInput = CustomTextField()
        passwordInput.placeholder = "Password"
        passwordInput.textColor = .black
        passwordInput.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        passwordInput.tintColor = UIColor(named: "AccentColor")
        passwordInput.autocapitalizationType = .none
        passwordInput.isSecureTextEntry = true
        
        return passwordInput
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = .systemCyan
        
        return activityIndicator
    }()
    
    var button: UIButton?
    
    var bruteButton: UIButton?
    
    var subViews: [UIView] {
        [logo, stackView, activityIndicator]
    }
    
    var formSubViews: [UITextField] {
        [loginInput, passwordInput]
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        subViews.forEach {
            scrollView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureButtons() {
        if let button = button, let bruteButton = bruteButton {
            [button, bruteButton].forEach {
                $0.layer.cornerRadius = 10
                $0.setBackgroundImage(UIImage(named: "BluePixel"), for: .normal)
                $0.clipsToBounds = true
                
                scrollView.addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
                
                NSLayoutConstraint.activate([
                    $0.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
                    $0.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
                    $0.heightAnchor.constraint(equalToConstant: 50),
                ])
            }
            
            NSLayoutConstraint.activate([
                button.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
                button.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16),
                bruteButton.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 16),
            ])
        }
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            logo.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            logo.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 120),
            logo.widthAnchor.constraint(equalToConstant: CGFloat(logoSize)),
            logo.heightAnchor.constraint(equalToConstant: CGFloat(logoSize)),
            
            activityIndicator.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -10),
            activityIndicator.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: -10)
        ])
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        stackView.clipsToBounds = true

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 120),
            stackView.heightAnchor.constraint(equalToConstant: 100),
        ])

        stackView.addArrangedSubview(loginInput)
        stackView.addArrangedSubview(passwordInput)
    }
    
}
