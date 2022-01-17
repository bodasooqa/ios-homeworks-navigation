//
//  InfoViewController.swift
//  Navigation
//
//  Created by t.lolaev on 22.10.2021.
//

import UIKit

class InfoViewController: ViewController {
    
    lazy var infoView: InfoView = {
        infoView = InfoView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        infoView.button = .createButton(title: "Show alert") {
            self.onButtonTap()
        }
        
        infoView.configureLayout()
        
        return infoView
    }()
    
    override func viewDidLoad() {
        view.addSubview(infoView)
    }
    
    func onButtonTap() {
        let alert = UIAlertController(title: "Ok?", message: "Just ok or not ok", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in print("It's OK :)") }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in print("It's not OK :(") }))
        
        present(alert, animated: true, completion: nil)
    }

}
