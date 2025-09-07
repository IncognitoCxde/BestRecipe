//
//  GoogleButton.swift
//  BestRecipe
//
//  Created by Zarina Sadykova on 31.08.25.
//

import UIKit
import SnapKit

class GoogleButton: UIButton {
    
    // MARK: - Initialization
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
        // Основные настройки кнопки
        backgroundColor = .white
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.withAlphaComponent(0.9).cgColor
        layer.cornerRadius = 25
        layer.masksToBounds = true
        
        // Создаем горизонтальный stack view для иконки и текста
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 12
        stackView.isUserInteractionEnabled = false // Чтобы клики проходили через на кнопку
        
        // Иконка Google
        let googleIcon = UIImageView()
        googleIcon.image = UIImage(named: "Google")
        googleIcon.contentMode = .scaleAspectFit
        googleIcon.snp.makeConstraints { make in
            make.width.height.equalTo(24)
        }
        
        // Текст
        let label = UILabel()
        label.text = "Continue with Google"
        label.font = UIFont(name: AppFont.Medium, size: 16)
        label.textColor = .black
        
        // Добавляем элементы в stack view
        stackView.addArrangedSubview(googleIcon)
        stackView.addArrangedSubview(label)
        
        // Добавляем stack view на кнопку
        addSubview(stackView)
        
        // Констрейнты для stack view
        stackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        // Добавляем обработчик нажатия для анимации
        addTarget(self, action: #selector(buttonPressed), for: .touchDown)
        addTarget(self, action: #selector(buttonReleased), for: [.touchUpInside, .touchUpOutside, .touchCancel])
    }
    
    // MARK: - Animation Methods
    @objc private func buttonPressed() {
        UIView.animate(withDuration: 0.1) {
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            self.backgroundColor = UIColor.systemGray6
        }
    }
    
    @objc private func buttonReleased() {
        UIView.animate(withDuration: 0.1) {
            self.transform = .identity
            self.backgroundColor = .white
        }
    }
    
    // MARK: - Public Methods
    func setCustomCornerRadius(_ radius: CGFloat) {
        layer.cornerRadius = radius
    }
    
    func setBorderColor(_ color: UIColor) {
        layer.borderColor = color.cgColor
    }
    
    func setBorderWidth(_ width: CGFloat) {
        layer.borderWidth = width
    }
}
