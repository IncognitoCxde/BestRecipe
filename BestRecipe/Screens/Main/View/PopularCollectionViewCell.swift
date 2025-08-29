//
//  PopularCategoryCell.swift
//  BestRecipe
//
//  Created by iMacbook on 8/21/25.
//

import UIKit

class PopularCollectionViewCell: UICollectionViewCell {
    static let identifier = "PopularCollectionViewCell"
    
    private let titleLabel = UILabel()
    private let imageView = UIImageView()
    private let rectangularBackground = UIView()
    private let timeLabel = UILabel()
    private let timeCount = UILabel()
    private let saveButton = UIButton.configureSaveButton()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(rectangularBackground)
        contentView.addSubview(titleLabel)
        contentView.addSubview(imageView)
        contentView.addSubview(timeLabel)
        contentView.addSubview(timeCount)
        contentView.addSubview(saveButton)
        
        rectangularBackground.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.leading.trailing.equalToSuperview().inset(5)
            make.height.equalTo(180)
        }
        
        imageView.snp.makeConstraints { make in
            make.bottom.equalTo(rectangularBackground.snp.top).offset(50)
            make.leading.equalToSuperview().inset(50)
            make.height.width.equalTo(100)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(15)
            make.centerX.equalToSuperview().inset(3)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.leading.equalTo(rectangularBackground.snp.leading).inset(15)
        }
        
        timeCount.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(5)
            make.leading.equalTo(timeLabel.snp.leading)
        }
        
        saveButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(15)
            make.top.equalTo(timeLabel.snp.top).inset(5)
            make.width.equalTo(60)
            make.height.equalTo(65)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func  configure(with recipe: Recipe) {
        rectangularBackground.backgroundColor = .neutral40
        rectangularBackground.layer.cornerRadius = 12
        rectangularBackground.clipsToBounds = true
        titleLabel.text = recipe.title
        titleLabel.font = UIFont(name: AppFont.SemiBold, size: 15)
        titleLabel.numberOfLines = 2
        titleLabel.textColor = .neutral100
        titleLabel.textAlignment = .center
        imageView.image = UIImage(named: recipe.image)
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        timeLabel.text = "Time"
        timeLabel.textColor = .neutral60
        timeLabel.font = UIFont(name: AppFont.Regular, size: 13)
        timeCount.text = "\(recipe.timeTaken ?? 0) mins"
        timeCount.font = UIFont(name: AppFont.SemiBold, size: 14)
        timeCount.textColor = .neutral100
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)

    }
    
    @objc func saveButtonTapped() {
        print("saved!")
        saveButton.setImage(UIImage(named: "BookmarkSelected"), for: .normal)
    }
}

