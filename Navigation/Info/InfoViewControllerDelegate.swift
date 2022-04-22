//
//  InfoViewDelegate.swift
//  Navigation
//
//  Created by t.lolaev on 22.04.2022.
//

import NetworkService

protocol InfoViewControllerDelegate {
    func getData(callback: @escaping (String) -> Void) -> Void
}

class InfoViewControllerDataset: InfoViewControllerDelegate {
    
    func getData(callback: @escaping (String) -> Void) {
        NetworkService.getTodo(callback: callback)
    }
    
}
