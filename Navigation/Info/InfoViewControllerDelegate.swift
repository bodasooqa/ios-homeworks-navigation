//
//  InfoViewDelegate.swift
//  Navigation
//
//  Created by t.lolaev on 22.04.2022.
//

import NetworkService
import Foundation

protocol InfoViewControllerDelegate {
    func getTodo(callback: @escaping (String) -> Void) -> Void
    func getPlanet(callback: @escaping (String, [String]?) -> Void) -> Void
    func getResident(residentUrl: String, callback: @escaping (String) -> Void) -> Void
}

class InfoViewControllerDataset: InfoViewControllerDelegate {
    
    func getTodo(callback: @escaping (String) -> Void) {
        NetworkService.getTodo(callback: callback)
    }
    
    
    func getPlanet(callback: @escaping (String, [String]?) -> Void) {
        NetworkService.getPlanet(callback: callback)
    }
    
    
    func getResident(residentUrl: String, callback: @escaping (String) -> Void) {
        NetworkService.getResident(residentUrl: residentUrl, callback: callback)
    }
    
}
