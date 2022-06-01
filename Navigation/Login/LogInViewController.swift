//
//  LogInViewController.swift
//  Navigation
//
//  Created by t.lolaev on 01.11.2021.
//

import UIKit
import FirebaseAuth
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
        loginView.button?.isEnabled = false
        loginView.bruteButton = CustomButton(title: "Get password", titleColor: .white, action: { [weak self] in
            guard let self = self else { return }
            
            // Пароль длиною в 4 символа, чтоб не сильно долго ждать
            let generatedPassword = String((0..<4).map{ _ in String().printable.randomElement()! })
            
            self.loginView.activityIndicator.startAnimating()
            
            let queue = DispatchQueue(label: "bruteForce", qos: .userInitiated)
            
            queue.async {
                self.delegate.bruteForce(passwordToUnlock: generatedPassword)
                DispatchQueue.main.async {
                    self.loginView.activityIndicator.stopAnimating()
                    self.loginView.passwordInput.text = generatedPassword
                    self.loginView.passwordInput.isSecureTextEntry = false
                }
            }
        })
        
        loginView.configureButtons()
        
        loginView.loginInput.addTarget(self, action: #selector(onLoginInputEdit), for: .editingChanged)
        loginView.passwordInput.addTarget(self, action: #selector(onLoginInputEdit), for: .editingChanged)
        
        return loginView
    }()
    
    private var delegate: LoginViewControllerDelegate
    
    init(with delegate: LoginViewControllerDelegate) {
        self.delegate = delegate
        
        super.init("Profile")
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
    
    @objc func onLoginInputEdit() {
        if let loginInputText = loginView.loginInput.text, let passwordInputText = loginView.passwordInput.text {
            if loginInputText.count > 0 && passwordInputText.count > 0 {
                loginView.button?.isEnabled = true
            } else {
                loginView.button?.isEnabled = false
            }
        } else {
            loginView.button?.isEnabled = false
        }
    }
    
    func goToProfile() {
        ifHasCredentials { username, password in
            delegate.checkCredentials(username: username, password: password) { [weak self] user, error in
                guard let self = self else { return }
                
                if let error = error {
                    self.handleError(error)
                }
                
                if let _ = user {
                    let userService = CurrentUserService()
                    self.onButtonTap?(username, userService)
                }
            }
        }
    }
    
    func handleError(_ error: NSError) {
        let authError = AuthErrorCode(_nsError: error)
        
        switch authError.code {
        case .userNotFound:
            presentAlert(title: "It's Ok", description: "\(authError.localizedDescription) We will register a new user with the specified data.")
        default:
            presentAlert(description: authError.localizedDescription)
        }
    }
    
    func presentAlert(title: String? = "Error", description: String) {
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
