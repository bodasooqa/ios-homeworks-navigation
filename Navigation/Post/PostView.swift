//
//  PostView.swift
//  Navigation
//
//  Created by t.lolaev on 22.10.2021.
//

import UIKit
import SnapKit

class PostView: UIView {
    
    lazy var descriptionLabel: UILabel = {
        descriptionLabel = UILabel()
        descriptionLabel.isHidden = true
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        
        return descriptionLabel
    }()
    
    lazy var imageView: UIImageView = {
        imageView = UIImageView()
        imageView.isHidden = true
        
        return imageView
    }()
    
    var subViews: [UIView] {
        [descriptionLabel, imageView]
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureLayout()
    }
    
    func set(postData: PostData) {
        if let image = UIImage(named: postData.image) {
            imageView.image = image
            imageView.isHidden = false
        }
        
        descriptionLabel.text = postData.description
        descriptionLabel.isHidden = false
    }

    private func configureLayout() {
        subViews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(200)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.width.equalToSuperview().offset(-32)
        }
    }
}
