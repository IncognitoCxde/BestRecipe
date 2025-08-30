//
//  RecentRecipesViewController.swift
//  BestRecipe
//
//  Created by iMacbook on 8/30/25.
//

import UIKit

class RecentRecipesViewController: UIViewController {
    
    // MARK: - Variables
    
    let recentTitle = UILabel()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setUpUI()
    }
    
    // MARK: - UI
    
    private func setUpUI() {
        setupCustomBackButton()
        setUpTitle()
        configureConstraints()
    }
    
    func setUpTitle() {
        recentTitle.text = "Recent recipes"
        recentTitle.font = UIFont(name: AppFont.SemiBold, size: 25)
        recentTitle.textColor = .neutral100
        recentTitle.textAlignment = .center
        view.addSubview(recentTitle)
    }
    
    
    private func setupCustomBackButton() {
        let backButton = UIButton(type: .system)
        let icon = UIImage(systemName: "arrow.left")?.withRenderingMode(.alwaysTemplate)
        backButton.setImage(icon, for: .normal)
        backButton.tintColor = .neutral100
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    // MARK: - Constraints
    
    func configureConstraints() {
        recentTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(80)
            make.leading.equalToSuperview().inset(110)
        }
    }
    
    @objc private func backTapped() {
        navigationController?.popViewController(animated: true)
    }

}
