//
//  IngredientView.swift
//  BestRecipe
//
//  Created by Administration  on 26/08/25.
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

    init(ingredient: Ingredient) {
        super.init(frame: .zero)
        setupUI(ingredient: ingredient)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI(ingredient: Ingredient) {
        backgroundColor = UIColor.systemGray5
        layer.cornerRadius = 10
        clipsToBounds = true

        imageView.image = UIImage(named: ingredient.imageName) ?? UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints { $0.size.equalTo(40) }

        nameLabel.text = ingredient.name
        nameLabel.font = .systemFont(ofSize: 16, weight: .bold)
        nameLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)

        quantityLabel.text = ingredient.quantity
        quantityLabel.font = .systemFont(ofSize: 14)
        quantityLabel.textColor = .gray
        quantityLabel.setContentHuggingPriority(.required, for: .horizontal)

        // MARK: - Initial Checkbox Setup
        checkboxButton.layer.cornerRadius = 11.5
        checkboxButton.layer.borderWidth = 2
        checkboxButton.layer.borderColor = UIColor.black.cgColor
        checkboxButton.backgroundColor = .black
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
            checkboxButton.backgroundColor = .systemRed
            checkboxButton.layer.borderColor = UIColor.systemRed.cgColor
            let checkmark = UIImage(systemName: "checkmark")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 12, weight: .bold))
            checkboxButton.setImage(checkmark, for: .normal)
            checkboxButton.tintColor = .white
        } else {
            checkboxButton.backgroundColor = .black
            checkboxButton.layer.borderColor = UIColor.black.cgColor
            let checkmark = UIImage(systemName: "checkmark")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 12, weight: .bold))
            checkboxButton.setImage(checkmark, for: .normal)
            checkboxButton.tintColor = .white

        }
    }
}
