//
//  CategoryIndicator.swift
//  homework
//
//  Created by Zarina Sadykova on 24.08.25.
//

import UIKit
import SnapKit

// Контейнер для индикаторов
final class OnboardingIndicatorsView: UIView {
    // Цвета из ассетов
    private let activeColor = UIColor(named: "Primary 30")
    private let inactiveColor = UIColor(named: "Neutral 40")
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10 
        stack.distribution = .equalSpacing
        stack.alignment = .center
        return stack
    }()
    
    private var indicatorViews: [UIView] = []
    var onIndicatorTapped: ((Int) -> Void)?
    private var currentPage: Int = 0
    
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
            make.width.equalTo(140) // Фиксированная ширина 140
            make.height.equalTo(8)
        }
        
        // Создаем три индикатора
        for i in 0..<3 {
            let indicatorView = UIView()
            indicatorView.backgroundColor = i == 0 ? activeColor : inactiveColor
            indicatorView.layer.cornerRadius = 4
            indicatorView.isUserInteractionEnabled = true
            indicatorView.tag = i
            
            // Добавляем жест нажатия
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(indicatorTapped(_:)))
            indicatorView.addGestureRecognizer(tapGesture)
            
            // Устанавливаем размеры
            indicatorView.snp.makeConstraints { make in
                make.width.equalTo(40)
                make.height.equalTo(8)
            }
            
            stackView.addArrangedSubview(indicatorView)
            indicatorViews.append(indicatorView)
        }
    }
    
    @objc private func indicatorTapped(_ gesture: UITapGestureRecognizer) {
        guard let tappedIndex = gesture.view?.tag else { return }
        onIndicatorTapped?(tappedIndex)
    }
    
    func setCurrentPage(_ page: Int) {
        currentPage = page
        
        // Обновляем цвета всех индикаторов
        for (index, indicatorView) in indicatorViews.enumerated() {
            indicatorView.backgroundColor = index == page ? activeColor : inactiveColor
        }
    }
}
