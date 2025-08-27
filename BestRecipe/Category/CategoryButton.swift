//
//  CategoryButton.swift
//  homework
//
//  Created by Zarina Sadykova on 19.08.25.
//
import UIKit

class CustomButton: UIButton {

    // MARK: - Public Properties
    var customCornerRadius: CGFloat = 12 {
        didSet {
            layer.cornerRadius = customCornerRadius
        }
    }
    
    // MARK: - Initialization
    convenience init(title: String, cornerRadius: CGFloat = 12) {
        self.init(frame: .zero)
        setTitle(title, for: .normal)
        self.customCornerRadius = cornerRadius
        setupButton()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    // MARK: - Configuration
    private func setupButton() {
        setTitleColor(.white, for: .normal)
        titleLabel?.font = .SemiBold(size: 20)
        titleLabel?.adjustsFontSizeToFitWidth = false
        titleLabel?.minimumScaleFactor = 1.0
        titleLabel?.lineBreakMode = .byClipping
        backgroundColor = .primary50
        layer.cornerRadius = customCornerRadius
        layer.masksToBounds = true
        contentEdgeInsets = UIEdgeInsets(top: 10, left: 18, bottom: 10, right: 18)
    }
    
   
    // MARK: - Public Methods
    func setCornerRadius(_ radius: CGFloat) {
        customCornerRadius = radius
        layer.cornerRadius = radius
    }
}

