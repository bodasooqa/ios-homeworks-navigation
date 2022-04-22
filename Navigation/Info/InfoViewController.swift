//
//  InfoViewController.swift
//  Navigation
//
//  Created by t.lolaev on 22.10.2021.
//

import UIKit

class InfoViewController: ViewController {
    
    let delegate: InfoViewControllerDelegate
    
    lazy var infoView: InfoView = {
        infoView = InfoView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        infoView.button = .createButton(title: "Show alert") {
            self.onButtonTap()
        }
        
        infoView.configureLayout()
        
        return infoView
    }()
    
    init(with delegate: InfoViewControllerDelegate) {
        self.delegate = delegate
        super.init("String")
        
        setData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view.addSubview(infoView)
    }
    
    func setData() {
        let queue = DispatchQueue(label: "get-data", qos: .userInitiated)
        queue.async {
            self.delegate.getData { title in
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    
                    self.infoView.label.text = title
                }
            }
        }
        
    }
    
    func onButtonTap() {
        let alert = UIAlertController(title: "Ok?", message: "Just ok or not ok", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in print("It's OK :)") }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in print("It's not OK :(") }))
        
        present(alert, animated: true, completion: nil)
    }

}
