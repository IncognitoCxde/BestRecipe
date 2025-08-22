//
//  SectionHeaderReusableView.swift
//  BestRecipe
//
//  Created by iMacbook on 8/21/25.
//

import UIKit

class SectionHeaderReusableView: UICollectionReusableView {
    static let identifier = "SectionHeaderReusableView"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: AppFont.SemiBold, size: 21)
        label.textColor = .neutral100
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String) {
        titleLabel.text = title
    }
}

