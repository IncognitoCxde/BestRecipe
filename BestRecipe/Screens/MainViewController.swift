//
//  ViewController.swift
//  BestRecipe
//
//  Created by iMacbook on 8/15/25.
//

// MARK: - Imports

import UIKit
import SnapKit

// MARK: - Controller

class MainViewController: UIViewController {
    
    // MARK: - Variables
    
    let titleLabel = UILabel()
    let titleLabel2 = UILabel()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    // MARK: - UI
    
    func setUpUI() {
        configureNavTitle()
        view.backgroundColor = .white
    }
    
    // MARK: - Navigation
    
    func configureNavTitle() {
        titleLabel.text = "Get amazing recipes"
        titleLabel.textColor = UIColor(named: "Neutal 100")
        titleLabel.font = UIFont(name: "SemiBold", size: 27)
        titleLabel.textAlignment = .left
        view.addSubview(titleLabel)
        
        titleLabel2.text = "for cooking"
        titleLabel2.textColor = UIColor(named: "Neutal 100")
        titleLabel2.font = UIFont(name: "SemiBold", size: 17)
        titleLabel2.textAlignment = .left
        view.addSubview(titleLabel2)
        
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(30)
            make.top.equalTo(80)
        }
        
        titleLabel2.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().inset(30)
        }
        
//        navigationItem.title = "Get amazing recipes for cooking "
//
//        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor(named: "Neutral 100"), NSAttributedString.Key.font: UIFont(name: "Poppins-SemiBold", size: 21)!]
//        
//        navigationController?.navigationBar.titleTextAttributes = textAttributes as [NSAttributedString.Key : Any]
//        navigationController?.navigationBar.isHidden = false
    }

}

