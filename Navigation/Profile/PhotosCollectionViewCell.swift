//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by t.lolaev on 16.11.2021.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "cv-photo-cell"
    
    lazy var photoImage: UIImageView = {
        photoImage = UIImageView()
        
        return photoImage
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.addSubview(photoImage)
        photoImage.translatesAutoresizingMaskIntoConstraints = false
        
        configureLayout()
    }
    
    func set(image: UIImage?) {
        if let image = image {
            photoImage.image = image
        }
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
