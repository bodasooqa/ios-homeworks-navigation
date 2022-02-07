//
//  PostViewModel.swift
//  Navigation
//
//  Created by t.lolaev on 26.01.2022.
//

import UIKit

protocol PostViewModelProtocol {
    
    func fetchData(completion: @escaping (_ data: PostData) -> Void)
    
    func back()
    
}

class PostViewModel: PostViewModelProtocol {
    
    weak var coordinator: FeedCoordinator?
    
    func fetchData(completion: @escaping (_ data: PostData) -> Void) {
        DispatchQueue.main.async {
            sleep(2)
            completion(PostData(description: "Money! I love money", image: "Crab"))
        }
    }
    
    func back() {
        coordinator?.stop()
    }
    
}
