//
//  Logo.swift
//  BestRecipe
//
//  Created by Zarina Sadykova on 31.08.25.
//

import UIKit
import SnapKit

final class SquareView: UIView {
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupConstraints()
    }
    
    // MARK: - Setup
    
    private func setupView() {
        backgroundColor = .clear
        layer.cornerRadius = 15 // Круглые уголки с радиусом 15
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        // Фиксированные размеры 160x160
        snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(300)
        }
    }
    
    // MARK: - Public Methods
    
    func setBackgroundColor(_ color: UIColor) {
        backgroundColor = color
    }
    
    func setCornerRadius(_ radius: CGFloat) {
        layer.cornerRadius = radius
    }
    
    func addBorder(width: CGFloat, color: UIColor) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
}

// MARK: - Usage Example
extension SquareView {
    
    // Пример создания SquareView с логотипом
    static func createWithLogo() -> SquareView {
        let squareView = SquareView()
        let imageView = UIImageView()
        
        // Загрузка изображения "AppLogo" из ассетов
        if let image = UIImage(named: "AppLogo") {
            imageView.image = image
        }
        
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15 // Также делаем круглые углы у изображения
        imageView.layer.masksToBounds = true
        
        squareView.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
        
        return squareView
    }
}
