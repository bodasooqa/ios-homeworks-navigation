//
//  CustomButton.swift
//  Navigation
//
//  Created by t.lolaev on 17.01.2022.
//

import UIKit

class CustomButton: UIButton {
    
    private var callback: (() -> Void)?
    
    init(title: String, titleColor: UIColor? = .black, action: @escaping () -> Void) {
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        
        if let titleColor = titleColor {
            setTitleColor(titleColor, for: .normal)
        }
        
        setAction(action: action)
    }
    
    init(image: UIImage?, action: @escaping () -> Void) {
        super.init(frame: .zero)
        
        if let image = image {
            setImage(image, for: .normal)
        }
        
        setAction(action: action)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setAction(action: @escaping () -> Void) {
        callback = action
        addTarget(self, action: #selector(doCallback), for: .touchUpInside)
    }
    
    @objc private func doCallback() {
        callback?()
    }
    
}
