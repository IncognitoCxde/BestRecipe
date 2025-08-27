//
//  CategoryLable.swift
//  homework
//
//  Created by Zarina Sadykova on 21.08.25.
//
import UIKit

class CustomLabel: UILabel {

    // MARK: - Initialization
    convenience init(text: String) {
        self.init(frame: .zero)
        self.text = text
        setupLabel()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLabel()
    }
    
    // MARK: - Configuration
    private func setupLabel() {
        textColor = .white
        font = UIFont.Bold(size: 60) // большой, но адаптивный
        textAlignment = .center
        numberOfLines = 0
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.6
    }
}


// Кастомный лейбл для разноцветного текста
final class MulticolorTitleLabel: UIView {
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 0
        stack.alignment = .center
        return stack
    }()
    
    init() {
        super.init(frame: .zero)
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
    }
    
    func setText(_ text: String, coloredParts: [String: [String]], color: UIColor) {
        // Очищаем предыдущие лейблы
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        let lines = text.components(separatedBy: "\n")
        let thirdColor = color
        
        for (index, line) in lines.enumerated() {
            let attributedString = NSMutableAttributedString(string: line)
            
            // Устанавливаем белый цвет для всей строки по умолчанию
            attributedString.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: line.count))
            
            // Ищем и окрашиваем части для текущей строки
            let stringIndex = String(index)
            if let partsForLine = coloredParts[stringIndex] {
                for part in partsForLine {
                    if let range = line.range(of: part) {
                        let nsRange = NSRange(range, in: line)
                        attributedString.addAttribute(.foregroundColor, value: thirdColor, range: nsRange)
                    }
                }
            }
            
            let label = UILabel()
            label.attributedText = attributedString
            label.font = UIFont.systemFont(ofSize: 40, weight: .bold)
            label.textAlignment = .center
            label.numberOfLines = 0
            label.adjustsFontSizeToFitWidth = true
            label.minimumScaleFactor = 0.1
            
            stackView.addArrangedSubview(label)
        }
    }
}
