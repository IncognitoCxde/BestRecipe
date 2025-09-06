//
//  IngredientCustomView.swift
//  BestRecipe
//
//  Created by iMacbook on 9/6/25.
//

import UIKit

class IngredientCustomView: UIView {
    
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    private let amountLabel = UILabel()
    
    init(ingredient: ingredient) {
        super.init(frame: .zero)
        setupUI(ingredient: ingredient)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI(ingredient: ingredient) {
        backgroundColor = .neutral40
        layer.cornerRadius = 10
        clipsToBounds = true
        
        
        imageView.loadImage(from: ingredient.image ?? "")
        imageView.tintColor = .primary50
        imageView.contentMode = .scaleAspectFit
        
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(32)
        }
        
        nameLabel.text = ingredient.name
        nameLabel.font = UIFont(name: AppFont.Regular, size: 16)
        nameLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        amountLabel.text = String(ingredient.amount ?? 0.0) + " " + (ingredient.unit ?? "unit")
        amountLabel.font = UIFont(name: AppFont.Regular, size: 14)
        amountLabel.textColor = .neutral60
        amountLabel.setContentHuggingPriority(.required, for: .horizontal)
        
        let infoStack = UIStackView(arrangedSubviews: [nameLabel, amountLabel])
        infoStack.axis = .horizontal
        infoStack.spacing = 8
        infoStack.alignment = .center
        
        let mainStack = UIStackView(arrangedSubviews: [imageView, infoStack])
        mainStack.axis = .horizontal
        mainStack.spacing = 12
        mainStack.alignment = .center

        addSubview(mainStack)
        mainStack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(12)
        }
    }

}
