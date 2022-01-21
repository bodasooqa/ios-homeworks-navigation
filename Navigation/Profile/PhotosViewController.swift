//
//  PhotosViewController.swift
//  Navigation
//
//  Created by t.lolaev on 15.11.2021.
//

import UIKit
import iOSIntPackage

class PhotosViewController: ViewController {
    
    let imagePublisherFacade: ImagePublisherFacade = ImagePublisherFacade()
    
    let margin: CGFloat = 8
    
    var imgIndexes: [Int]?
    
    var images: [UIImage] {
        imgIndexes?.map({ index in
            UIImage(named: "Goblin-\(index)")!
        }) ?? []
    }
    
    var publisherImages: [UIImage] = []
    
    lazy var collectionView: UICollectionView = {
        let cvLayout = UICollectionViewFlowLayout()
        cvLayout.minimumInteritemSpacing = margin
        cvLayout.minimumLineSpacing = margin
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: cvLayout)
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    init(_ title: String, photos: [Int]) {
        super.init(title)
        
        imgIndexes = photos
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        imagePublisherFacade.removeSubscription(for: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        
        view.backgroundColor = .white
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        configureLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        imagePublisherFacade.subscribe(self)
        imagePublisherFacade.addImagesWithTimer(time: 1, repeat: images.count, userImages: images)
    }
 
    func configureLayout() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath) as! PhotosCollectionViewCell
        cell.set(image: publisherImages[indexPath.row])

        return cell
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        publisherImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - margin * 4) / 3
        return CGSize(width: width, height: width)
    }
    
}

extension PhotosViewController: ImageLibrarySubscriber {
    
    func receive(images: [UIImage]) {
        publisherImages = images
        collectionView.reloadData()
    }

}
