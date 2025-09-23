//
//  ResultsTableViewCell.swift
//  BestRecipe
//
//  Created by iMacbook on 9/19/25.
//

import UIKit

class ResultsTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: ResultsTableViewCell.self)
    
    let networkingManager: HomeNetworkingProtocol = HomeNetworkingManager()
    
    private let recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: AppFont.semiBold, size: 18)
        label.textColor = .white
        label.numberOfLines = 2
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
            make.bottom.equalTo(recipeImageView.snp.bottom).inset(10)
        }
    }
    
    func configure(with recipe: SearchRecipe) {
        recipeImageView.setImage(from: recipe.image ?? "chef")
        titleLabel.text = recipe.title
    }

}
