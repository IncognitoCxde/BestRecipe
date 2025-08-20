//
//  TrendingCollectionViewCell.swift
//  BestRecipe
//
//  Created by iMacbook on 8/20/25.
//

import UIKit

class TrendingCollectionViewCell: UICollectionViewCell {
    static let identifier = "TrendingCollectionViewCell"
    
    private let titleLabel = UILabel()
    private let imageView = UIImageView()
    private let creatorLabel = UILabel()
    private let creatorImage = UIImageView()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(titleLabel)
        contentView.addSubview(imageView)
        contentView.addSubview(creatorImage)
        contentView.addSubview(creatorLabel)
        
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(120)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview().inset(5)
            make.height.equalTo(20)
        }
        
        creatorImage.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(5)
            make.width.height.equalTo(30)
        }
        creatorImage.layer.cornerRadius = 15
        creatorImage.clipsToBounds = true
        
        creatorLabel.snp.makeConstraints { make in
            make.centerY.equalTo(creatorImage)
            make.leading.equalTo(creatorImage.snp.trailing).offset(5)
            make.trailing.equalToSuperview().inset(5)
            make.height.equalTo(30)
            
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func  configure(with recipe: Recipe) {
        titleLabel.text = recipe.title
        titleLabel.font = UIFont(name: AppFont.SemiBold, size: 12)
        titleLabel.textColor = UIColor(named: "Neutral 100")
        imageView.image = UIImage(named: recipe.image)
        creatorImage.image = UIImage(named: recipe.creator.profileImageUrl ?? "")
        creatorLabel.text = "By \(recipe.creator.name)"
    }
    
}
