//
//  RecentCollectionViewCell.swift
//  BestRecipe
//
//  Created by iMacbook on 8/22/25.
//

import UIKit

class RecentCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "RecentCollectionViewCell"
    
    private let titleLabel = UILabel()
    private let imageView = UIImageView()
    private let creatorLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(titleLabel)
        contentView.addSubview(imageView)
        contentView.addSubview(creatorLabel)
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.leading.trailing.equalToSuperview().inset(5)
            make.height.equalTo(160)
        }
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.leading.equalTo(imageView.snp.leading)
        }
        
        creatorLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.leading)
            make.bottom.equalToSuperview()
            make.height.equalTo(30)
            
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func  configure(with recipe: Recipe) {
        titleLabel.text = recipe.title
        titleLabel.font = UIFont(name: AppFont.SemiBold, size: 15)
        titleLabel.textColor = .neutral100
        imageView.image = UIImage(named: recipe.image)
        creatorLabel.text = "By \(recipe.creator.name)"
        creatorLabel.textColor = .neutral60
        creatorLabel.font = UIFont(name: AppFont.Regular, size: 13)
    }
}
