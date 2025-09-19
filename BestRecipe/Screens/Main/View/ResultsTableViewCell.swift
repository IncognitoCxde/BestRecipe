//
//  ResultsTableViewCell.swift
//  BestRecipe
//
//  Created by iMacbook on 9/19/25.
//

import UIKit

class ResultsTableViewCell: UITableViewCell {
    
    static let identifier = ResultsTableViewCell.self
    
    let networkingManager: HomeNetworkingProtocol = HomeNetworkingManager()
    
    private let recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        let vignetteOverlay = UIView()
        vignetteOverlay.isUserInteractionEnabled = false
        vignetteOverlay.backgroundColor = .clear
        
        imageView.addSubview(vignetteOverlay)
        vignetteOverlay.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor.black.withAlphaComponent(0.5).cgColor,
            UIColor.clear.cgColor,
            UIColor.clear.cgColor,
            UIColor.black.withAlphaComponent(0.5).cgColor
        ]
        gradient.locations = [0, 0.1, 0.7, 1] as [NSNumber]
        gradient.frame = UIScreen.main.bounds
        vignetteOverlay.layer.addSublayer(gradient)
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: AppFont.semiBold, size: 18)
        label.textColor = .white
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
        label.font = UIFont(name: AppFont.regular, size: 14)
        label.textColor = .white
        return label
    }()
    
    let numOfIngredients: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: AppFont.regular, size: 14)
        label.textColor = .white
        return label
    }()
    
   let timeTaken: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: AppFont.regular, size: 14)
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
        contentView.addSubview(numOfIngredients)
        contentView.addSubview(timeTaken)
        
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
            make.leading.equalTo(recipeImageView.snp.leading).inset(20)
            make.trailing.equalTo(recipeImageView.snp.trailing).inset(30)
            make.bottom.equalTo(recipeImageView.snp.bottom).inset(40)
        }
        
        ratingStackView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(10)
        }
        
        numOfIngredients.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalTo(titleLabel.snp.leading)
        }
        
        timeTaken.snp.makeConstraints { make in
            make.top.equalTo(numOfIngredients.snp.top)
            make.leading.equalTo(numOfIngredients.snp.trailing).offset(5)
        }
                
    }
    
    func configure(with recipe: SearchRecipe) {
        recipeImageView.setImage(from: recipe.image ?? "")
        titleLabel.text = recipe.title
        ratingLabel.text = "\(recipe.rating ?? 5.0)"
        numOfIngredients.text = "\(recipe.numberOfIngredients ?? 5) Ingredients |"
        timeTaken.text = "\(recipe.timeTaken ?? 15) mins"
        
    }

}
