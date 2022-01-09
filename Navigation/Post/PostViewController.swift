//
//  PostViewController.swift
//  Navigation
//
//  Created by t.lolaev on 22.10.2021.
//

import UIKit
import StorageService

class PostViewController: ViewController {
    
    init(post: Post) {
        super.init(post.author)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var postView: PostView = {
        postView = PostView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        return postView
    }()
    
    override func viewDidLoad() {
        view.addSubview(postView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Info", style: .plain, target: self, action: #selector(onBarButtonTap(_:)))
    }
    
    @objc func onBarButtonTap(_ sender: UIBarButtonItem) {
        let infoViewController = InfoViewController("Info")
        present(infoViewController, animated: true)
    }
    
}
