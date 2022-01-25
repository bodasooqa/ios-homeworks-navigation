//
//  FeedViewController.swift
//  Navigation
//
//  Created by t.lolaev on 21.10.2021.
//

import UIKit
import StorageService
import CurrentUserService

class FeedViewController: ViewController {
    
    weak var checkerService: CheckerService?
    
    var onButtonTap: ((_ post: Post) -> Void)?
    
    init(with checkerService: CheckerService) {
        super.init("Feed")
        
        self.checkerService = checkerService
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var feedView: FeedView = {
        feedView = FeedView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        
        feedView.button1 = .createButton(title: "Button 1") {
            self.goToPost()
        }
        
        feedView.button2 = .createButton(title: "Button 2") {
            self.goToPost()
        }
        
        feedView.checkButton = .createButton(title: "Check text", action: {
            self.onCheckButtonTap()
        })
        
        feedView.configureStackView()
        
        return feedView
    }()
    
    override func viewDidLoad() {
        view.addSubview(feedView)
    }
    
    func goToPost() {
        let post = Post(author: "bodasooqa", description: "Description", image: "", likes: 0, views: 0)
        onButtonTap?(post)
    }
    
    func onCheckButtonTap() {
        if let text = feedView.textField.text, text.count != 0 {
            if let result = checkerService?.check(word: text), result {
                feedView.textLabel.text = "Success"
                feedView.textLabel.textColor = .systemGreen
            } else {
                feedView.textLabel.text = "Fail"
                feedView.textLabel.textColor = .systemRed
            }
            
            feedView.stackView.constraints.first { $0.identifier == FeedView.heightIdentifier }?.isActive = false
            
            feedView.stackView.heightAnchor.constraint(equalToConstant: 275).isActive = true
            feedView.textLabel.isHidden = false
        }
    }
}
