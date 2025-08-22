//
//  TabBarController.swift
//  BestRecipe
//
//  Created by iMacbook on 8/22/25.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let itemOffset: CGFloat = 25
        
        var tabBarFrame = tabBar.frame
        
        tabBarFrame.origin.y -= itemOffset / 2
        tabBarFrame.size.height += itemOffset
        tabBar.frame = tabBarFrame
        
        for tabBarSubView in tabBar.subviews {
            if let tabBarButton = tabBarSubView as? UIControl {
                var frame = tabBarButton.frame
                frame.origin.y += itemOffset / 2
                tabBarButton.frame = frame
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBarItems()
        setupTabs()
        
        
        guard let tabBarItems = tabBar.items, !tabBarItems.isEmpty else { return }
    }
    
    func setupTabBarItems() {
        tabBar.tintColor = .primary50
        tabBar.backgroundColor = .white
        tabBar.unselectedItemTintColor = .neutral50
        tabBar.isTranslucent = true
    }
    
    func setupTabs() {
        let v1 = createNavigationController(with: UIImage(systemName: "house"), vc: MainViewController())
        let v2 = createNavigationController(with: UIImage(systemName: "bookmark"), vc: SavedViewController())
        let v3 = createNavigationController(with: UIImage(systemName: "bell"), vc: NotificationViewController())
        let v4 = createNavigationController(with: UIImage(systemName: "person"), vc: ProfileViewController())
        
        self.setViewControllers([v1, v2, v3, v4], animated: true)
    }
    
    func createNavigationController(with image: UIImage?, vc: UIViewController) -> UINavigationController {
        let nc = UINavigationController(rootViewController: vc)
        nc.tabBarItem.image = image
        return nc
    }
}
