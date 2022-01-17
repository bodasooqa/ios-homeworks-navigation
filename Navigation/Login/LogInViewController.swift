//
//  LogInViewController.swift
//  Navigation
//
//  Created by t.lolaev on 01.11.2021.
//

import UIKit
import CurrentUserService

class LoginViewController: ViewController {
    
    lazy var loginView: LoginView = {
        loginView = LoginView()
        loginView.button = CustomButton(title: "Log In", titleColor: .white, action: {
            self.onButtonClick()
        })
        
        loginView.configureButton()
        
        return loginView
    }()
    
    private var delegate: LoginViewControllerDelegate?
    
    init(with delegate: LoginViewControllerDelegate) {
        super.init("Profile")
        
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    override func loadView() {
        super.loadView()
        view.addSubview(loginView)
        
        loginView.putIntoSafeArea(view: view)
    }
    
    func ifHasCredentials(callback: (_ username: String, _ password: String) -> Void) {
        if let username = loginView.loginInput.text, username.count != 0, let password = loginView.passwordInput.text, password.count != 0 {
            callback(username, password)
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardInfo = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue
        let keyboardSize = keyboardInfo.cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        loginView.scrollView.contentInset = contentInsets
        loginView.scrollView.scrollIndicatorInsets = contentInsets
        let bottomOffset = CGPoint(x: 0, y: loginView.scrollView.contentSize.height - loginView.scrollView.bounds.height + loginView.scrollView.contentInset.bottom)
        loginView.scrollView.setContentOffset(bottomOffset, animated: true)

    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        loginView.scrollView.contentInset = .zero
        loginView.scrollView.scrollIndicatorInsets = .zero
    }
    
    func onButtonClick() {
        ifHasCredentials { username, password in
            if let available = delegate?.checkCredentials(username: username, password: password), available {
                #if DEBUG
                let userService = TestUserService()
                #else
                let userService = CurrentUserService()
                #endif
                navigationController?.pushViewController(ProfileViewController(username: username, userService: userService), animated: true)
            }
        }
    }
}
