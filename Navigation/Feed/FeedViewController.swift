//
//  FeedViewController.swift
//  Navigation
//
//  Created by t.lolaev on 21.10.2021.
//

import UIKit
import StorageService

class FeedViewController: ViewController {
    
    init() {
        super.init("Feed")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var feedView: FeedView = {
        feedView = FeedView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        [feedView.button1, feedView.button2].forEach{
            $0.addTarget(self, action: #selector(onButtonTap(_:)), for: .touchUpInside)
        }
        return feedView
    }()
    
    override func viewDidLoad() {
        view.addSubview(feedView)
    }
    
    @objc func onButtonTap(_ sender: UIButton) {
        let post = Post(author: "bodasooqa", description: "Description", image: "", likes: 0, views: 0)
        let postViewController = PostViewController(post: post)
        navigationController?.pushViewController(postViewController, animated: true)
    }
}
