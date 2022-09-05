//
//  DataBaseManager.swift
//  Navigation
//
//  Created by Bodasooqa on 04.09.2022.
//

import CoreData
import StorageService

class DataBaseManager {
    
    static let shared = DataBaseManager()
    
    var posts: [PostEntity] = []
    
    private lazy var managedObjectModel: NSManagedObjectModel = {
        guard let modelURL = Bundle.main.url(forResource: "PostModel", withExtension: "momd") else {
            fatalError("Undable to find Data Model")
        }
        
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Undable to find Data Model")
        }
        
        return managedObjectModel
    }()
    
    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        
        let documentsDirectoryURL = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask )[0]
        
        
        let storeName = "PostModel.sqlite"
        let persistentStoreURL = documentsDirectoryURL.appendingPathComponent(storeName)
        
        do {
            try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: persistentStoreURL, options: nil)
        } catch {
            fatalError("Unable to load Persistent Store")
        }
        
        return persistentStoreCoordinator
    }()
    
    private(set) lazy var managedObjectContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
         
        return managedObjectContext
    }()
    
    init() {
        _ = persistentStoreCoordinator
    }
    
    func getPosts(callback: () -> Void) {
        let fetchRequest = PostEntity.fetchRequest()

        do {
            let posts = try managedObjectContext.fetch(fetchRequest)

            self.posts = posts
            callback()
        } catch let error {
            print(error)
        }
    }
    
    func addPost(_ post: Post?) {
        if let post = post {
            let fetchRequest = PostEntity.fetchRequest()

            do {
                var posts = try managedObjectContext.fetch(fetchRequest)
                
                if let newPost = NSEntityDescription.insertNewObject(forEntityName: "PostEntity", into: managedObjectContext) as? PostEntity {
                    newPost.author = post.author
                    newPost.desc = post.description
                    newPost.image = post.image
                    newPost.likes = Int16(post.likes)
                    newPost.views = Int16(post.views)
                    
                    posts.append(newPost)
                } else {
                    fatalError("Unable to Insert new Post")
                }
                
                try managedObjectContext.save()
            } catch let error {
                print(error)
            }
        }
    }
    
}
