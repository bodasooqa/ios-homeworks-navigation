//
//  ProfileViewController.swift
//  Navigation
//
//  Created by t.lolaev on 21.10.2021.
//

import UIKit
import StorageService
import CurrentUserService


class ProfileViewController: ViewController {
    
    var userService: UserService?
    
    var username: String?
    
    let imgIndexes: [Int] = Array(1...20)
    
    private var statusText = String()
    
    var profileHeaderView: ProfileHeaderView?

    fileprivate lazy var tableView: UITableView = UITableView(frame: .zero, style: .grouped)
    
    fileprivate var posts: [Post] = PostsService.posts
    
    lazy var photosViewController: PhotosViewController = PhotosViewController("Photos", photos: imgIndexes)
    
    lazy var backgroundView: UIView = {
        backgroundView = UIView()
        backgroundView.isHidden = true
        backgroundView.backgroundColor = .black
        backgroundView.layer.opacity = 0
        backgroundView.layer.zPosition = 1
        
        return backgroundView
    }()
    
    lazy var closeButton: UIButton = {
        closeButton = UIButton(type: .custom)
        
        if let image = UIImage(systemName: "xmark") {
            closeButton.setImage(image, for: .normal)
        }
        
        closeButton.tintColor = .white
        closeButton.layer.zPosition = 2
        closeButton.layer.opacity = 0
            
        return closeButton
    }()
    
    init(username: String, userService: UserService) {
        super.init("Profile")
        
        self.username = username
        self.userService = userService
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        #if DEBUG
        view.backgroundColor = .systemRed
        #else
        view.backgroundColor = .systemBlue
        #endif
        
        view.addSubview(tableView)
        tableView.putIntoSafeArea(view: view)
        
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: PhotosTableViewCell.identifier)
        tableView.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: ProfileHeaderView.identifier)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        onTextFieldChage(profileHeaderView?.textField)
    }
    
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotosTableViewCell.identifier, for: indexPath) as? PhotosTableViewCell else {
                fatalError()
            }
            
            cell.button.addTarget(self, action: #selector(goToPhotos(_:)), for: .touchUpInside)
            cell.set(photos: imgIndexes)
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as? PostTableViewCell else {
                fatalError()
            }
            
            cell.set(post: posts[indexPath.row - 1])
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let profileHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProfileHeaderView.identifier) as? ProfileHeaderView
        
        guard let profileHeaderView = profileHeaderView else {
            fatalError()
        }
        
        configureBackgroundView(profileHeaderView)
        
        if let username = username, let user = userService?.getUserByName(username) {
            profileHeaderView.headerLabel.text = user.fullName
            profileHeaderView.statusLabel.text = user.status
            profileHeaderView.textField.text = user.status
            
            if let avatar = UIImage(named: user.avatar) {
                profileHeaderView.imageView.image = avatar
            }
        }
        
        profileHeaderView.button.addTarget(self, action: #selector(onButtonTap(_:)), for: .touchUpInside)
        profileHeaderView.textField.addTarget(self, action: #selector(onTextFieldChage(_:)), for: .editingChanged)
        
        let gesture = UITapGestureRecognizer(
            target: self,
            action: #selector(onImageTap)
        )
        
        profileHeaderView.imageView.addGestureRecognizer(gesture)

        return profileHeaderView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 160
        } else {
            return UITableView.automaticDimension
        }
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 160
        } else {
            return UITableView.automaticDimension
        }
    }
    
}

extension ProfileViewController {
    
    func configureBackgroundView(_ profileHeaderView: ProfileHeaderView) {
        profileHeaderView.addSubview(backgroundView)
        backgroundView.putIntoSafeArea(view: profileHeaderView, height: view.frame.height)
        backgroundView.addSubview(closeButton)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        closeButton.addTarget(self, action: #selector(onCloseTap), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -16),
        ])
    }
    
    @objc func onButtonTap(_ sender: UIButton) {
        profileHeaderView?.statusLabel.text = statusText
    }
    
    @objc func onTextFieldChage(_ sender: TextField?) {
        statusText = sender?.text ?? ""
    }
    
    @objc func goToPhotos(_ sender: UIButton) {
        navigationController?.pushViewController(photosViewController, animated: true)
    }
    
    @objc func onImageTap() {
        guard let profileHeaderView = self.profileHeaderView else {
            fatalError()
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseOut]) {
            profileHeaderView.imageView.frame = CGRect(x: 0, y: 0, width: profileHeaderView.frame.width, height: profileHeaderView.frame.width)
            profileHeaderView.imageView.layer.cornerRadius = 0
            profileHeaderView.imageView.layer.borderWidth = 0
            
            profileHeaderView.setConstraintsForImageView(size: profileHeaderView.frame.width, left: 0, top: self.tableView.frame.height / 2 - profileHeaderView.imageView.frame.height / 2)
            profileHeaderView.layoutIfNeeded()

            self.backgroundView.isHidden = false
            self.backgroundView.layer.opacity = 0.5
        } completion: { Bool in
            UIView.animate(withDuration: 0.3) {
                self.closeButton.layer.opacity = 1
            } completion: { Bool in
                self.tableView.isScrollEnabled = false
            }
        }

    }
    
    @objc func onCloseTap() {
        guard let profileHeaderView = self.profileHeaderView else {
            fatalError()
        }
        
        UIView.animate(withDuration: 0.3) {
            self.closeButton.layer.opacity = 0
        } completion: { Bool in
            UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseOut]) {
                self.backgroundView.layer.opacity = 0
                
                profileHeaderView.imageView.frame = CGRect(x: 0, y: 0, width: profileHeaderView.imageSize, height: profileHeaderView.imageSize)
                profileHeaderView.imageView.layer.cornerRadius = profileHeaderView.imageView.frame.width / 2
                profileHeaderView.imageView.layer.borderWidth = 3
                
                profileHeaderView.setConstraintsForImageView(size: profileHeaderView.imageSize, left: 16, top: 16)
                profileHeaderView.layoutIfNeeded()
            } completion: { Bool in
                self.tableView.isScrollEnabled = true
                self.backgroundView.isHidden = true
            }
        }
    }
    
}
