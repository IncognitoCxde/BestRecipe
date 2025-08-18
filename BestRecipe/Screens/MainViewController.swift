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
        navigationItem.title = "Get amazing recipes for cooking "
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor(named: "Neutral 100"), NSAttributedString.Key.font: UIFont(name: "Poppins-SemiBold", size: 21)!]
        
        navigationController?.navigationBar.titleTextAttributes = textAttributes as [NSAttributedString.Key : Any]
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }

}

