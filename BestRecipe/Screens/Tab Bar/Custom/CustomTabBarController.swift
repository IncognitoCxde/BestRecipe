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
        updateCenterButtonFrame()
        
        let customTabBar = CurvedTabBar()
         
        
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
        let buttonSize: CGFloat = 60
        let x = tabBar.center.x
        let y = tabBar.frame.origin.y - (buttonSize / 2)

        centerButton.frame = CGRect(
            x: x - buttonSize / 2,
            y: y,
            width: buttonSize,
            height: buttonSize
        )

        centerButton.setImage(UIImage(systemName: "plus"), for: .normal)
        centerButton.tintColor = .white
        centerButton.backgroundColor = .primary50
        centerButton.layer.cornerRadius = buttonSize / 2
        
        view.addSubview(centerButton)
        view.bringSubviewToFront(centerButton)
        
        centerButton.addTarget(self, action: #selector(centerButtonTapped), for: .touchUpInside)
    }
    
    @objc func centerButtonTapped() {
        let createVC = CreateRecipeViewController()
        navigationController?.pushViewController(createVC, animated: true)
    }
    
    private func updateCenterButtonFrame() {
        let buttonSize: CGFloat = 60
        let x = tabBar.center.x
        let verticalOffset: CGFloat = 60
        let y = tabBar.frame.origin.y - (buttonSize / 2) - verticalOffset

        centerButton.frame = CGRect(
            x: x - buttonSize / 2,
            y: y,
            width: buttonSize,
            height: buttonSize
        )
    }


}
