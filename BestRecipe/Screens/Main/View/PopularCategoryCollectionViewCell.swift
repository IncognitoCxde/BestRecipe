//
//  PopularCategoryCollectionViewCell.swift
//  BestRecipe
//
//  Created by iMacbook on 8/21/25.
//

import UIKit

class PopularCategoryCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PopularCategoryCollectionViewCell"
    
    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: AppFont.semiBold, size: 15)
        label.textColor = .primary30
        label.textAlignment = .center
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            label.textColor = isSelected ? .primary60 : .primary30
            label.font = isSelected ? UIFont(name: AppFont.semiBold, size: 17) : UIFont(name: AppFont.semiBold, size: 15)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.equalTo(contentView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing).inset(10)
            make.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(with text: String, isSelected: Bool) {
        label.text = text
    }
    
    
}
