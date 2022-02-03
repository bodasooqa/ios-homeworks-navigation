//
//  LogInViewController.swift
//  Navigation
//
//  Created by t.lolaev on 01.11.2021.
//

import UIKit
import CurrentUserService

class LoginViewController: ViewController {
    
    var onButtonTap: ((_ username: String, _ service: UserService) -> Void)?
    
    weak var coordinator: ProfileCoordinator? {
        didSet {
            coordinator?.onFinish = {
                print("Authorized")
            }
        }
    }
    
    lazy var loginView: LoginView = {
        loginView = LoginView()
        
        loginView.button = CustomButton(title: "Log In", titleColor: .white, action: {
            self.goToProfile()
        })
        loginView.bruteButton = CustomButton(title: "Get password", titleColor: .white, action: { [weak self] in
            guard let self = self else { return }
            
            // Пароль длиною в 4 символа, чтоб не сильно долго ждать
            let generatedPassword = String((0..<4).map{ _ in String().printable.randomElement()! })
            
            self.loginView.activityIndicator.startAnimating()
            
            let queue = DispatchQueue(label: "bruteForce", qos: .userInitiated)
            
            queue.async {
                self.delegate?.bruteForce(passwordToUnlock: generatedPassword)
                DispatchQueue.main.async {
                    self.loginView.activityIndicator.stopAnimating()
                    self.loginView.passwordInput.text = generatedPassword
                    self.loginView.passwordInput.isSecureTextEntry = false
                }
            }
        })
        
        loginView.configureButtons()
        
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
    
    func goToProfile() {
        ifHasCredentials { username, password in
            if let available = delegate?.checkCredentials(username: username, password: password), available {
                #if DEBUG
                let userService = TestUserService()
                #else
                let userService = CurrentUserService()
                #endif
                onButtonTap?(username, userService)
            }
        }
    }
}
