//
//  Coordinator.swift
//  Navigation
//
//  Created by t.lolaev on 25.01.2022.
//

protocol Coordinator: AnyObject {
    
    func start()
    
}

protocol FinishCoordinator {
    
    var onFinish: (() -> Void)? { get set }
    
}
