//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by t.lolaev on 12.11.2021.
//

import UIKit
import StorageService
import iOSIntPackage

class PostTableViewCell: UITableViewCell {
    
    static let identifier: String = "cell"
    
    lazy var headerLabel: UILabel = {
        headerLabel = UILabel()
        headerLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        headerLabel.textColor = .black
        headerLabel.numberOfLines = 2
        
        return headerLabel
    }()
    
    lazy var postImage: UIImageView = {
        postImage = UIImageView()
        postImage.layer.masksToBounds = false
        postImage.clipsToBounds = true
        postImage.contentMode = .scaleAspectFit
        postImage.backgroundColor = .black
        
        return postImage
    }()
    
    lazy var descriptionLabel: UILabel = {
        descriptionLabel = UILabel()
        descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        descriptionLabel.textColor = .systemGray
        descriptionLabel.numberOfLines = 0
        
        return descriptionLabel
    }()
    
    lazy var likesLabel: UILabel = {
        likesLabel = UILabel()
        likesLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        likesLabel.textColor = .black
        likesLabel.numberOfLines = 1
        
        return likesLabel
    }()
    
    lazy var viewsLabel: UILabel = {
        viewsLabel = UILabel()
        viewsLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        viewsLabel.textColor = .black
        
        return viewsLabel
    }()
    
    var post: Post?
    
    var subViews: [UIView] {
        [headerLabel, postImage, descriptionLabel, likesLabel, viewsLabel]
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addRecognizer()
        
        subViews.forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(post: Post) {
        self.post = post
        headerLabel.text = post.author
        setImage(post.image)
        descriptionLabel.text = post.description
        likesLabel.text = "Likes: \(post.likes)"
        viewsLabel.text = "Views: \(post.views)"
    }
    
    func set(postEntity: PostEntity) {
        headerLabel.text = postEntity.author ?? ""
        setImage(postEntity.image ?? "")
        descriptionLabel.text = postEntity.desc ?? ""
        likesLabel.text = "Likes: \(postEntity.likes)"
        viewsLabel.text = "Views: \(postEntity.views)"
    }
    
    private func setImage(_ image: String) {
        ImageProcessor().processImage(sourceImage: UIImage(named: image)!, filter: .crystallize(radius: 10)) { (img: UIImage?) in
            if let img = img {
                postImage.image = img
            }
        }
    }
    
    func configureLayout() {
        let marginGuide = contentView.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor),
            headerLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor),
            headerLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor),

            postImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postImage.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 16),
            postImage.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            postImage.heightAnchor.constraint(equalTo: contentView.widthAnchor),

            descriptionLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 16),

            likesLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor),
            likesLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            likesLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor),

            viewsLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor),
            viewsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            viewsLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor),
        ])
    }
    
    private func addRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        tap.numberOfTapsRequired = 2
        addGestureRecognizer(tap)
    }
    
}

extension PostTableViewCell {
    
    @objc public func doubleTapped() {
        DataBaseManager.shared.addPost(post)
    }
    
}
