//
//  FeedViewController.swift
//  Navigation
//
//  Created by t.lolaev on 21.10.2021.
//

import UIKit

struct Post {
    let title: String
}

class FeedViewController: ViewController {
    
    init() {
        super.init("Feed")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var feedView: FeedView = {
        feedView = FeedView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        feedView.button.addTarget(self, action: #selector(onButtonTap(_:)), for: .touchUpInside)
        return feedView
    }()
    
    override func viewDidLoad() {
        view.addSubview(feedView)
    }
    
    @objc func onButtonTap(_ sender: UIButton) {
        let post = Post(title: "New post")
        let postViewController = PostViewController(post: post)
        navigationController?.pushViewController(postViewController, animated: true)
    }
}
