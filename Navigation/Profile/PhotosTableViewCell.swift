//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by t.lolaev on 14.11.2021.
//

import UIKit
import iOSIntPackage

class PhotosTableViewCell: UITableViewCell {
    
    static let identifier: String = "photos"
    
    let margin: CGFloat = 12
    let spacing: CGFloat = 8
    
    var cgImages: [UIImage] = []
    
    lazy var label: UILabel = {
        label = UILabel()
        label.text = "Photos"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        
        return label
    }()
    
    var button: UIButton?
    
    lazy var collectionView: UICollectionView = {
        let cvLayout = UICollectionViewFlowLayout()
        cvLayout.scrollDirection = .horizontal
        cvLayout.minimumInteritemSpacing = spacing
        cvLayout.minimumLineSpacing = spacing
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: cvLayout)
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)

        return collectionView
    }()
    
    var subViews: [UIView] {
        [label, collectionView]
    }
    
    var images: [UIImage]?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        subViews.forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        configureLayout()
    }
    
    func getCGImages() {
        guard let images = images else { return }

        ImageProcessor().processImagesOnThread(
            sourceImages: images.compactMap { $0 },
            filter: .crystallize(radius: 10),
            qos: .default
        ) { [weak self] images in
            guard let self = self else { return }
            self.cgImages = (images.compactMap { $0 }).map({ image in
                UIImage(cgImage: image)
            }).compactMap { $0 }
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    func configureButton() {
        if let button = button {
            contentView.addSubview(button)
            button.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                button.topAnchor.constraint(equalTo: contentView.topAnchor, constant: margin),
                button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -margin),
                button.widthAnchor.constraint(equalToConstant: 30),
                button.heightAnchor.constraint(equalToConstant: 30),
            ])
        }
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: margin),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: margin),
            
            collectionView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: margin),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -margin),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: margin),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -margin)
        ])
    }
    
    func set(photos: [UIImage?]) {
        images = photos.compactMap { $0 }
        getCGImages()
    }
    
}

extension PhotosTableViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cgImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
        cell.set(image: (cgImages[indexPath.row]))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (contentView.frame.width - margin * 2 - spacing * 3) / 4
        return CGSize(width: width, height: width)
    }
    
}

class PhotoCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "cv-cell"
    
    lazy var photoImage: UIImageView = {
        photoImage = UIImageView()
        photoImage.layer.masksToBounds = false
        photoImage.clipsToBounds = true
        photoImage.contentMode = .scaleAspectFill
        photoImage.layer.cornerRadius = 6
        
        return photoImage
    }()
    
    func set(image: UIImage) {
        photoImage.image = image
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.addSubview(photoImage)
        photoImage.translatesAutoresizingMaskIntoConstraints = false
        
        configureLayout()
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            photoImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            photoImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
}
