//
//  RecipeCell.swift
//  BestRecipe
//
//  Created by Irina  on 22/08/25.
//

import UIKit
import SnapKit

class RecipeCell: UITableViewCell {
    var onSaveTapped: ((Int) -> Void)?
    private var recipeID: Int?

    // MARK: - UI Elements
    
    private let recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: AppFont.SemiBold, size: 18)
        label.textColor = .neutral100
        label.textAlignment = .left
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let ratingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 4
        stackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        stackView.layer.cornerRadius = 8
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        return stackView
    }()
    
    private let ratingIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "star.fill"))
        imageView.tintColor = .neutral100
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: AppFont.Regular, size: 14)
        label.textColor = .white
        return label
    }()
    
    let saveButton = SaveButton()

    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: AppFont.SemiBold, size: 14)
        label.textColor = .white
        label.backgroundColor = UIColor(white: 0, alpha: 0.5)
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        label.textAlignment = .center
        return label
    }()

    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .clear
        self.selectionStyle = .none
        setupViews()
        setupConstraints()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI Setup
    
    private func setupViews() {
        contentView.addSubview(recipeImageView)
        contentView.addSubview(titleLabel)
        
        ratingStackView.addArrangedSubview(ratingIcon)
        ratingStackView.addArrangedSubview(ratingLabel)
        
        recipeImageView.addSubview(ratingStackView)
        recipeImageView.addSubview(saveButton)
        recipeImageView.addSubview(timeLabel)
    }
    
    private func setupConstraints() {
        recipeImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(200)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(recipeImageView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(25)
            make.bottom.equalToSuperview().offset(-15)
        }
        
        ratingStackView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(10)
        }
        
        saveButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(10)
            make.width.height.equalTo(60)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview().inset(10)
            make.height.equalTo(35)
            make.width.equalTo(60)
        }
    }
    
    private func setupActions() {
        saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
    }
    
    // MARK: - Methods
    
    func configure(with recipe: Recipe) {
        self.recipeID = recipe.id
        saveButton.recipeID = recipe.id
        saveButton.onToggle = { [weak self] in
            guard let self = self else { return }
            self.onSaveTapped?(recipe.id)
        }

        saveButton.updateAppearance()
        titleLabel.text = recipe.title

        if let time = recipe.readyInMinutes {
            timeLabel.text = "\(time) min"
        } else {
            timeLabel.text = ""
        }

        recipeImageView.image = UIImage(named: "placeholderImage")
        if let url = URL(string: recipe.image) {
            ImageLoader.shared.loadImage(from: url) { [weak self] image in
                DispatchQueue.main.async {
                    if self?.recipeID == recipe.id {
                        self?.recipeImageView.image = image ?? UIImage(named: "placeholderImage")
                    }
                }
            }
        }
    }

    
    @objc private func saveButtonPressed() {
        guard let id = recipeID else { return }
        onSaveTapped?(id)
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let buttonPoint = convert(point, to: saveButton)
        if saveButton.bounds.contains(buttonPoint) {
            return saveButton
        }
        return super.hitTest(point, with: event)
    }

}
