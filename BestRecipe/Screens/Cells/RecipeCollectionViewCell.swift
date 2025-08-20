//
//  RecipeCollectionViewCell.swift
//  BestRecipe
//
//  Created by SORBON AZIMOV on 17/08/25.
//
import UIKit

class RecipeCollectionViewCell: UICollectionViewCell {
    static let identifier = "RecipeCollectionViewCell"

    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let timeLabel = UILabel()
    private let ratingView = UIView()
    private let favoriteButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)

        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        titleLabel.numberOfLines = 2
        contentView.addSubview(titleLabel)

        timeLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        contentView.addSubview(timeLabel)

        contentView.addSubview(ratingView)

        favoriteButton.setImage(UIImage(named: "favorite_icon"), for: .normal)
        contentView.addSubview(favoriteButton)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height - 60)
        titleLabel.frame = CGRect(x: 5, y: contentView.frame.height - 55, width: contentView.frame.width - 10, height: 20)
        timeLabel.frame = CGRect(x: 5, y: contentView.frame.height - 30, width: contentView.frame.width - 10, height: 20)
        ratingView.frame = CGRect(x: 5, y: contentView.frame.height - 25, width: 50, height: 20)
        favoriteButton.frame = CGRect(x: contentView.frame.width - 35, y: contentView.frame.height - 35, width: 30, height: 30)
    }

    func configure(with recipe: Recipe) {
        titleLabel.text = recipe.title
        timeLabel.text = "\(recipe.cookingTime) мин"
    }
}
