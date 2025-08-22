//
//  PopularCategoryCollectionViewCell.swift
//  BestRecipe
//
//  Created by iMacbook on 8/21/25.
//

import UIKit

class PopularCategoryCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PopularCategoryCollectionViewCell"
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: AppFont.SemiBold, size: 15)
        label.textColor = .primary30
        label.textAlignment = .center
        return label
    }()
    
//    override var isSelected: Bool {
//        didSet {
//            label.textColor = isSelected ? .white : .primary30
//        }
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(5)
            make.leading.equalTo(contentView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing).inset(10)
            make.bottom.equalToSuperview()
        }
        
//        let selectedView = UIView()
//        selectedView.backgroundColor = .primary50
//        selectedView.layer.masksToBounds = true
//        selectedView.layer.cornerRadius = 10
//        selectedBackgroundView = selectedView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(with text: String) {
        label.text = text
    }
}
