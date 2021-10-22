//
//  ProfileViewController.swift
//  Navigation
//
//  Created by t.lolaev on 21.10.2021.
//

import UIKit

class ProfileViewController: ViewController {
    
    init() {
        super.init("Profile")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = ProfileView()
    }
}
