//
//  ProfileViewController.swift
//  Navigation
//
//  Created by t.lolaev on 21.10.2021.
//

import UIKit

class ProfileViewController: ViewController {
    
    private var statusText = String()
    
    lazy var profileHeaderView: ProfileHeaderView = {
        profileHeaderView = ProfileHeaderView()
        profileHeaderView.button.addTarget(self, action: #selector(onButtonTap(_:)), for: .touchUpInside)
        profileHeaderView.textField.addTarget(self, action: #selector(onTextFieldChage(_:)), for: .editingChanged)
        return profileHeaderView
    }()
    
    lazy var profileView: ProfileView = {
        return ProfileView()
    }()
    
    init() {
        super.init("Profile")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = UIView()
        view.addSubview(profileView)
        profileView.addSubview(profileHeaderView)
        
        profileView.putIntoSafeArea(view: view)
        profileHeaderView.putIntoSafeArea(view: view, height: 220)
        
        let button: UIButton = .createButton(title: "Tap me")
        button.translatesAutoresizingMaskIntoConstraints = false
        
        profileView.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.leftAnchor.constraint(equalTo: profileView.leftAnchor),
            button.rightAnchor.constraint(equalTo: profileView.rightAnchor),
            button.bottomAnchor.constraint(equalTo: profileView.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    override func viewDidLoad() {
        onTextFieldChage(profileHeaderView.textField)
    }
    
    override func viewWillLayoutSubviews() {
        
    }
    
    @objc func onButtonTap(_ sender: UIButton) {
        profileHeaderView.statusLabel.text = statusText
    }
    
    @objc func onTextFieldChage(_ sender: TextField) {
        statusText = sender.text ?? ""
    }
    
}
