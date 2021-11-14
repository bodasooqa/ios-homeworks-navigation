//
//  ProfileViewController.swift
//  Navigation
//
//  Created by t.lolaev on 21.10.2021.
//

import UIKit

class ProfileViewController: ViewController {
    
    private var statusText = String()
    
    var profileHeaderView: ProfileHeaderView?

    fileprivate lazy var tableView: UITableView = UITableView(frame: .zero, style: .grouped)
    
    fileprivate var posts: [Post] = [
        Post(author: "bodasooqa", description: "Post #0 Post #0 Post #0 Post #0 Post #0 Post #0 Post #0 Post #0 Post #0 Post #0 Post #0 Post #0 Post #0 Post #0 Post #0 Post #0 Post #0 Post #0 Post #0 Post #0 Post #0 Post #0 Post #0 Post #0 Post #0 Post #0 Post #0 Post #0 Post #0 Post #0 ", image: "Bitcoin1", likes: 100, views: 200),
        Post(author: "netology", description: "Post #1", image: "Bitcoin2", likes: 30, views: 100),
        Post(author: "azamat", description: "Post #2", image: "Bitcoin3", likes: 80, views: 300),
        Post(author: "bodasooqa", description: "Post #3", image: "Bitcoin4", likes: 140, views: 400)
    ]
    
    init() {
        super.init("Profile")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.putIntoSafeArea(view: view)
        
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        tableView.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: ProfileHeaderView.identifier)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.layoutIfNeeded()
        
        onTextFieldChage(profileHeaderView?.textField)
    }

    @objc func onButtonTap(_ sender: UIButton) {
        profileHeaderView?.statusLabel.text = statusText
    }

    @objc func onTextFieldChage(_ sender: TextField?) {
        statusText = sender?.text ?? ""
    }
    
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as? PostTableViewCell else {
            fatalError()
        }
        
        cell.set(post: posts[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProfileHeaderView.identifier)

        profileHeaderView = header as? ProfileHeaderView

        profileHeaderView?.button.addTarget(self, action: #selector(onButtonTap(_:)), for: .touchUpInside)
        profileHeaderView?.textField.addTarget(self, action: #selector(onTextFieldChage(_:)), for: .editingChanged)

        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
}
