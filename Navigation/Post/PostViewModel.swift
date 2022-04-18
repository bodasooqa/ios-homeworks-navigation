//
//  PostViewModel.swift
//  Navigation
//
//  Created by t.lolaev on 26.01.2022.
//

import UIKit

protocol PostViewModelProtocol {
    
    var setTimeValue: ((_ value: Int) -> Void)! { get set }
    
    func fetchData(completion: @escaping (_ data: PostData) -> Void)
    
    func back()
    
}

class PostViewModel: PostViewModelProtocol {
    
    static let initialCounter = 5
    
    var timer: Timer!
    
    var counter = PostViewModel.initialCounter
    
    weak var coordinator: FeedCoordinator?
    
    public var setTimeValue: ((_ value: Int) -> Void)!
    
    func fetchData(completion: @escaping (_ data: PostData) -> Void) {
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.fireTimer), userInfo: nil, repeats: true)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            completion(PostData(description: "Money! I love money", image: "Crab"))
        }
    }
    
    func back() {
        coordinator?.stop()
    }
    
    @objc func fireTimer() {
        counter -= 1
        
        if counter == 0 {
            timer.invalidate()
        } else {
            setTimeValue(counter)
        }
    }
    
}
