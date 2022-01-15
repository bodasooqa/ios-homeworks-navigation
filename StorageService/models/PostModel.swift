//
//  PostModel.swift
//  StorageService
//
//  Created by t.lolaev on 09.11.2021.
//

public struct Post {
    
    public let author: String
    public let description: String
    public let image: String
    public let likes: Int
    public let views: Int
    
    public init(author: String, description: String, image: String, likes: Int, views: Int) {
        self.author = author
        self.description = description
        self.image = image
        self.likes = likes
        self.views = views
    }
    
}
