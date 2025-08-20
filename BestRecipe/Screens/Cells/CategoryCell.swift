//  CategoryCell.swift
//  BestRecipe
//
//  Created by SORBON AZIMOV on 19/08/25.
//
import UIKit
import SnapKit

class CategoryCell: UICollectionViewCell {
    
    // MARK: - UI Elements
    private let categoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        imageView.backgroundColor = .systemGray6
        return imageView
    }()
    
    private let overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        view.layer.cornerRadius = 16
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-Bold", size: 18)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    private let recipeCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-Regular", size: 14)
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        label.layer.cornerRadius = 12
        label.layer.masksToBounds = true
        return label
    }()
    
    // MARK: - Selection
    override var isSelected: Bool {
        didSet { updateSelectionState() }
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupUI() {
        backgroundColor = .clear
        contentView.layer.cornerRadius = 16
        contentView.layer.masksToBounds = true
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 8
        layer.shadowOpacity = 0.1
        contentView.addSubview(categoryImageView)
        contentView.addSubview(overlayView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(recipeCountLabel)
    }
    
    private func setupConstraints() {
        categoryImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        overlayView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-10)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
        }
        
        recipeCountLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.width.equalTo(80)
            make.height.equalTo(24)
        }
    }
    
    // MARK: - Configuration
    func configure(with category: RecipeCategory) {
        titleLabel.text = category.name
        recipeCountLabel.text = "\(category.recipeCount) рецептов"
        
        // Загрузка изображения категории
        if let imageName = category.imageName {
            categoryImageView.image = UIImage(named: imageName)
        } else {
            // Используем системные иконки для разных категорий
            let iconName = getIconName(for: category.name)
            categoryImageView.image = UIImage(systemName: iconName)
            categoryImageView.tintColor = .systemGray3
            categoryImageView.backgroundColor = .systemGray5
        }
        
        isSelected = category.isSelected
    }
    
    private func getIconName(for categoryName: String) -> String {
        let lowercased = categoryName.lowercased()
        
        switch lowercased {
        case let name where name.contains("завтрак") || name.contains("breakfast"):
            return "sunrise.fill"
        case let name where name.contains("обед") || name.contains("lunch"):
            return "sun.max.fill"
        case let name where name.contains("ужин") || name.contains("dinner"):
            return "moon.fill"
        case let name where name.contains("десерт") || name.contains("dessert"):
            return "birthday.cake.fill"
        case let name where name.contains("напиток") || name.contains("drink"):
            return "cup.and.saucer.fill"
        case let name where name.contains("салат") || name.contains("salad"):
            return "leaf.fill"
        case let name where name.contains("суп") || name.contains("soup"):
            return "drop.fill"
        case let name where name.contains("мясо") || name.contains("meat"):
            return "flame.fill"
        case let name where name.contains("рыба") || name.contains("fish"):
            return "fish.fill"
        case let name where name.contains("вегетариан") || name.contains("vegetarian"):
            return "carrot.fill"
        default:
            return "fork.knife"
        }
    }
    
    private func updateSelectionState() {
        if isSelected {
            UIView.animate(withDuration: 0.2) {
                self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                self.layer.borderWidth = 3
                self.layer.borderColor = UIColor.systemBlue.cgColor
            }
        } else {
            UIView.animate(withDuration: 0.2) {
                self.transform = CGAffineTransform.identity
                self.layer.borderWidth = 0
            }
        }
    }
    
    // MARK: - Reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        categoryImageView.image = nil
        titleLabel.text = nil
        recipeCountLabel.text = nil
        isSelected = false
        transform = .identity
        layer.borderWidth = 0
    }
    
    // MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 16).cgPath
    }
}
 

