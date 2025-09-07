//
//  IngredientView.swift
//  BestRecipe
//
//  Created by Irina  on 26/08/25.
//

import UIKit
import SnapKit

class IngredientView: UIView {
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    private let quantityLabel = UILabel()
    private let checkboxButton = UIButton(type: .custom)

    private var isChecked = false {
        didSet {
            updateCheckboxAppearance()
        }
    }

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

        if let imageName = ingredient.image {
            imageView.loadImage(from: ingredient.image ?? "")
        } else {
            imageView.image = UIImage(systemName: "square.dashed")
        }
        imageView.tintColor = .neutral60
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints { $0.size.equalTo(40) }

        nameLabel.text = ingredient.name ?? "No name"
        nameLabel.font = UIFont(name: AppFont.Regular, size: 16)
        nameLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)

        let amountText: String
        if let amount = ingredient.amount, let unit = ingredient.unit {
            amountText = "\(amount) \(unit)"
        } else if let amount = ingredient.amount {
            amountText = "\(amount)"
        } else {
            amountText = "-"
        }
        quantityLabel.text = amountText
        quantityLabel.font = UIFont(name: AppFont.Regular, size: 14)
        quantityLabel.textColor = .neutral60
        quantityLabel.setContentHuggingPriority(.required, for: .horizontal)

        checkboxButton.layer.cornerRadius = 11.5
        checkboxButton.layer.borderWidth = 2
        checkboxButton.layer.borderColor = UIColor.neutral100.cgColor
        checkboxButton.backgroundColor = .neutral100
        checkboxButton.tintColor = .white
        checkboxButton.setImage(nil, for: .normal)
        checkboxButton.snp.makeConstraints { $0.size.equalTo(23) }

        checkboxButton.addTarget(self, action: #selector(checkboxTapped), for: .touchUpInside)

        let infoStack = UIStackView(arrangedSubviews: [nameLabel, quantityLabel, checkboxButton])
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

        updateCheckboxAppearance()
    }

    @objc private func checkboxTapped() {
        isChecked.toggle()
    }

    private func updateCheckboxAppearance() {
        if isChecked {
            checkboxButton.backgroundColor = .primary50
            checkboxButton.layer.borderColor = UIColor.primary50.cgColor
            let checkmark = UIImage(systemName: "checkmark")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 12, weight: .bold))
            checkboxButton.setImage(checkmark, for: .normal)
            checkboxButton.tintColor = .white
        } else {
            checkboxButton.backgroundColor = .neutral100
            checkboxButton.layer.borderColor = UIColor.neutral100.cgColor
            checkboxButton.setImage(nil, for: .normal)
        }
    }
}
