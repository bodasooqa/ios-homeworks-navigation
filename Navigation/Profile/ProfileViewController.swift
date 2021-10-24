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
        
        [profileView, profileHeaderView].forEach { $0.putIntoSafeArea(view: view) }
    }
    
    override func viewDidLoad() {
        onTextFieldChage(profileHeaderView.textField)
    }
    
    override func viewWillLayoutSubviews() {
        profileHeaderView.frame = view.frame
    }
    
    @objc func onButtonTap(_ sender: UIButton) {
        profileHeaderView.statusLabel.text = statusText
    }
    
    @objc func onTextFieldChage(_ sender: TextField) {
        statusText = sender.text ?? ""
    }
    
}
