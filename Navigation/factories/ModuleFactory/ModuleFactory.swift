//
//  ModuleFactory.swift
//  Navigation
//
//  Created by t.lolaev on 26.01.2022.
//

import StorageService

class ModuleFactory {
    
    static let shared = ModuleFactory()
    
    private init() {}
    
    func createModule(name: Modules, post: Post?, coordinator: Coordinator) -> ViewController? {
        switch name {
        case .post:
            guard let post = post else { return nil }
            let viewModel = PostViewModel()
            viewModel.coordinator = coordinator as? FeedCoordinator
            return PostViewController(viewModel: viewModel, post: post)
        }
    }
    
}
