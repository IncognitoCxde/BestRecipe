//
//  SectionHeaderReusableView.swift
//  BestRecipe
//
//  Created by iMacbook on 8/21/25.
//

import UIKit

protocol SectionHeaderReusableViewDelegate: AnyObject {
    func sectionHeaderReusableViewDidTapSeeAll(in section: Int)
}

class SectionHeaderReusableView: UICollectionReusableView {
    
    static let identifier = "SectionHeaderReusableView"
    
    weak var delegate: SectionHeaderReusableViewDelegate?
    var section: Int = 0
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: AppFont.SemiBold, size: 21)
        label.textColor = .neutral100
        return label
    }()
    
    private let seeAllButton: UIButton = {
        let button = UIButton()
        button.setTitle("See all", for: .normal)
        button.setTitleColor(.primary50, for: .normal)
        button.titleLabel?.font = UIFont(name: AppFont.SemiBold, size: 17)
        return button
    }()
    
    private let arrowButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        button.tintColor = .neutral100
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        seeAllButton.addTarget(self, action: #selector(seeAllButtonTapped), for: .touchUpInside)
        addSubview(seeAllButton)
        arrowButton.addTarget(self, action: #selector(seeAllButtonTapped), for: .touchUpInside)
        addSubview(arrowButton)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        }
        
        seeAllButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(30)
            make.centerY.equalToSuperview().inset(30)
        }
        
        arrowButton.snp.makeConstraints { make in
            make.leading.equalTo(seeAllButton.snp.trailing).offset(5)
            make.centerY.equalTo(seeAllButton.snp.centerY)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String) {
        titleLabel.text = title
    }
    
    func configure(title: String, showButton: Bool, section: Int, delegate: SectionHeaderReusableViewDelegate) {
        titleLabel.text = title
        seeAllButton.isHidden = !showButton
        arrowButton.isHidden = !showButton
        self.section = section
        self.delegate = delegate
        
    }
    
    @objc func seeAllButtonTapped() {
        print("user transferred!")
        delegate?.sectionHeaderReusableViewDidTapSeeAll(in: section)
    }
}


