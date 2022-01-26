//
//  PostViewController.swift
//  Navigation
//
//  Created by t.lolaev on 22.10.2021.
//

import UIKit
import StorageService

class PostViewController: ViewController {
    
    var onBarButtonTap: (() -> Void)?
    
    var viewModel: PostViewModelProtocol
    
    init(viewModel: PostViewModelProtocol, post: Post) {
        self.viewModel = viewModel
        super.init(post.author)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var postView: PostView = PostView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
    
    override func viewDidLoad() {
        view.addSubview(postView)
        
        configureNavigationBar()
        fetchData()
    }
    
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Info", style: .plain, target: self, action: #selector(onRightBarButtonTap(_:)))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(onLeftBarButtonTap(_:)))
    }
    
    private func fetchData() {
        viewModel.fetchData { data in
            self.postView.set(postData: data)
        }
    }
    
    @objc func onRightBarButtonTap(_ sender: UIBarButtonItem) {
        onBarButtonTap?()
    }
    
    @objc func onLeftBarButtonTap(_ sender: UIBarButtonItem) {
        viewModel.back()
    }
    
}
