//
//  CategoryIndicator.swift
//  homework
//
//  Created by Zarina Sadykova on 24.08.25.
//

import UIKit
import SnapKit

// Контейнер для индикаторов с изображениями
final class OnboardingIndicatorsView: UIView {
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 16
        stack.distribution = .equalSpacing
        stack.alignment = .center
        return stack
    }()
    
    private let firstIndicator = UIImageView(image: UIImage(named: "FirstIndicator"))
    private let secondIndicator = UIImageView(image: UIImage(named: "SecondIndicator"))
    private let thirdIndicator = UIImageView(image: UIImage(named: "ThirdIndicator"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // Добавляем индикаторы в стек
        stackView.addArrangedSubview(firstIndicator)
        stackView.addArrangedSubview(secondIndicator)
        stackView.addArrangedSubview(thirdIndicator)
        
        // Настраиваем размеры изображений
        firstIndicator.snp.makeConstraints { make in
            make.width.height.equalTo(8)
        }
        secondIndicator.snp.makeConstraints { make in
            make.width.height.equalTo(8)
        }
        thirdIndicator.snp.makeConstraints { make in
            make.width.height.equalTo(8)
        }
        
        // По умолчанию активен первый индикатор
        setCurrentPage(0)
    }
    
    func setCurrentPage(_ page: Int) {
        // Просто скрываем/показываем индикаторы в зависимости от текущей страницы
        firstIndicator.isHidden = page != 0
        secondIndicator.isHidden = page != 1
        thirdIndicator.isHidden = page != 2
    }
}
