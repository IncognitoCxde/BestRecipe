//
//  TrendingTableViewCell.swift
//  BestRecipe
//
//  Created by iMacbook on 8/30/25.
//

import UIKit

class TrendingTableViewCell: UITableViewCell {
    
    static let identifier = "TrendingTableViewCell"
    
    private let recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
   let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: AppFont.SemiBold, size: 18)
       label.textColor = .neutral100
        label.numberOfLines = 2
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

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .clear
        self.selectionStyle = .none
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(recipeImageView)
        contentView.addSubview(titleLabel)
        
        ratingStackView.addArrangedSubview(ratingIcon)
        ratingStackView.addArrangedSubview(ratingLabel)
        
        recipeImageView.addSubview(ratingStackView)
    }
    
    private func setupConstraints() {
        recipeImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(200)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(25)
            make.top.equalTo(recipeImageView.snp.bottom).offset(10)
        }
        
        ratingStackView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(10)
        }
    }
    
    func configure(with recipe: SideRecipe) {
        recipeImageView.image = UIImage(named: recipe.image)
        titleLabel.text = recipe.title
        ratingLabel.text = "\(recipe.rating)"
    }

}
