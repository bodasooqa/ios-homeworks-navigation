//
//  FavoritesViewController.swift
//  Navigation
//
//  Created by Bodasooqa on 04.09.2022.
//

import UIKit

class FavoritesViewController: ViewController {
    
    fileprivate lazy var tableView: UITableView = UITableView(frame: .zero, style: .grouped)
    
    private var posts: [PostEntity] {
        DataBaseManager.shared.posts
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchData()
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.putIntoSafeArea(view: view)
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func fetchData() {
        DataBaseManager.shared.getPosts { [weak self] in
            guard let self = self else { return }
            
            print(posts.count)
            self.tableView.reloadData()
        }
    }
    
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as? PostTableViewCell else {
            fatalError()
        }
        
        cell.set(postEntity: posts[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
}
