//
//  CustomTabBarController.swift
//  BestRecipe
//
//  Created by iMacbook on 8/30/25.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    let centerButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCenterButton()
        
        let customTabBar = CurvedTabBar()
        setValue(customTabBar, forKey: "tabBar")
        
        let mvc = MainViewController()
        mvc.tabBarItem = UITabBarItem(title: nil,
                                      image: UIImage.homeInactive,
                                      selectedImage: UIImage.homeActive.withRenderingMode(.alwaysOriginal))
        
        let svc = SavedScreenViewController()
        svc.tabBarItem = UITabBarItem(title: nil,
                                      image: UIImage.bookmarkInactive,
                                      selectedImage: UIImage.bookmarkActive.withRenderingMode(.alwaysOriginal))
        
        let nvc = NotificationViewController()
        nvc.tabBarItem = UITabBarItem(title: nil,
                                      image: UIImage.bellInactive,
                                      selectedImage: UIImage.bellInactive.withTintColor(.primary50, renderingMode: .alwaysOriginal))
        
        let pvc = ProfileViewController()
        pvc.tabBarItem = UITabBarItem(title: nil,
                                      image: UIImage.profileInactive,
                                      selectedImage: UIImage.profileActive.withRenderingMode(.alwaysOriginal))
        
        viewControllers = [mvc, svc, nvc, pvc]
        
        
    }
    
    private func setUpCenterButton() {
        let buttonsize: CGFloat = 60
        centerButton.frame = CGRect(
            x: CGFloat(Int(tabBar.bounds.width / 2 - buttonsize / 2)),
            y: 730,
            width: buttonsize,
            height: buttonsize
        )
        
        centerButton.setImage(UIImage(systemName: "plus"), for: .normal)
        centerButton.tintColor = .white
        centerButton.backgroundColor = .primary50
        centerButton.layer.cornerRadius = 30
        
        view.addSubview(centerButton)
        view.bringSubviewToFront(centerButton)
        
        centerButton.addTarget(self, action: #selector(centerButtonTapped), for: .touchUpInside)
    }
    
    @objc func centerButtonTapped() {
        let createVC = CreateRecipeViewController()
        navigationController?.pushViewController(createVC, animated: true)
    }
}
