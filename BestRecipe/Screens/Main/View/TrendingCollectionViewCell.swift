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
    private let ratingButton = UIButton()
    private let saveButton = SaveButton()
    private var toggleState = 0

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(imageView)
        contentView.addSubview(creatorImage)
        contentView.addSubview(creatorLabel)
        contentView.addSubview(saveButton)
    }
    
    func setUpConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.leading.trailing.equalToSuperview().inset(5)
            make.height.equalTo(200)
        }
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(5)
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
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.top).inset(5)
            make.trailing.equalTo(imageView.snp.trailing).inset(10)
            make.width.equalTo(60)
            make.height.equalTo(65)
        }
    }
    
    func  configure(with recipe: Recipe) {
        saveButton.recipeID = recipe.id
        saveButton.updateAppearance()
        
        titleLabel.text = recipe.title
        titleLabel.font = UIFont(name: AppFont.semiBold, size: 17)
        titleLabel.textColor = .neutral100
        imageView.setImage(from: recipe.image)
        creatorImage.image = UIImage(named: recipe.author?.profileImageUrl ?? "chef")
        creatorLabel.text = "By \(recipe.author?.name ?? "Zeelicious Recipes")"
        creatorLabel.textColor = .neutral60
        creatorLabel.font = UIFont(name: AppFont.regular, size: 14)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    @objc func saveButtonTapped() {
        print("saved!")
    }
    
    var recipeID: Int? {
        didSet {
            saveButton.recipeID = recipeID
            saveButton.updateAppearance()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        recipeID = nil
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        if window != nil {
            saveButton.updateAppearance()
        }
    }
    
}
