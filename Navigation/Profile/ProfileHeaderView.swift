//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by t.lolaev on 23.10.2021.
//

import UIKit
import SnapKit

class ProfileHeaderView: UITableViewHeaderFooterView {
    
    static let identifier: String = "header"
    
    let imageSize: CGFloat = 120
    
    var imageViewConstraints: [NSLayoutConstraint] = [] {
        didSet {
            NSLayoutConstraint.activate(imageViewConstraints)
        }
    }
    
    lazy var imageView: UIImageView = {
        let image = UIImage(named: "Guest")!
        
        imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: imageSize, height: imageSize)
        imageView.layer.borderWidth = 3
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.layer.zPosition = 2
        
        return imageView
    }()
    
    lazy var headerLabel: UILabel = {
        headerLabel = UILabel()
        
        headerLabel.text = "Guest"
        headerLabel.textColor = .black
        headerLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        return headerLabel
    }()
    
    lazy var statusLabel: UILabel = {
        statusLabel = UILabel()
        
        statusLabel.text = textField.text
        statusLabel.textColor = .gray
        statusLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        
        return statusLabel
    }()
    
    lazy var textField: TextField = {
        textField = TextField()
        
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.text = "Waiting for something..."
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 12
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        
        return textField
    }()
    
    lazy var button: UIButton = {
        button = UIButton()
        button.setTitle("Set status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.7
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.cornerRadius = 12

        return button
    }()
    
    var subViews: [UIView] {
        [imageView, headerLabel, button, statusLabel, textField]
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        subViews.forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureLayout() {
        setConstraintsForImageView(size: imageSize, left: 16, top: 16)
        
        headerLabel.snp.makeConstraints { make in
            make.left.equalTo(imageSize + 16 * 2)
            make.top.equalTo(27)
        }
        
        button.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageSize + 50 + 16)
            make.width.equalToSuperview().offset(-32)
            make.height.equalTo(50)
        }
        
        textField.snp.makeConstraints { make in
            make.left.equalTo(imageSize + 16 * 2)
            make.right.equalTo(safeAreaLayoutGuide).offset(-16)
            make.height.equalTo(40)
            make.bottom.equalTo(button.snp.top).offset(-16)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.left.equalTo(imageSize + 16 * 2)
            make.bottom.equalTo(button.snp.top).offset(-68)
        }
    }
    
    func setConstraintsForImageView(size: CGFloat, left: CGFloat, top: CGFloat) {
        disableImageViewConstraints()
        
        let width = imageView.widthAnchor.constraint(equalToConstant: CGFloat(size)),
            height = imageView.heightAnchor.constraint(equalToConstant: CGFloat(size)),
            left = imageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: left),
            top = imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: top)
        
        imageViewConstraints = [width, height, left, top]
    }
    
    func disableImageViewConstraints() {
        imageViewConstraints.forEach { $0.isActive = false }
    }
    
}
