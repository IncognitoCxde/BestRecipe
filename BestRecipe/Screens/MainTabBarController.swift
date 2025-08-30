import UIKit

final class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupViewControllers()
    }
    
    private func setupTabBar() {
        tabBar.backgroundColor = .systemBackground
        tabBar.tintColor = .systemBlue
        tabBar.unselectedItemTintColor = .systemGray
        
        // Ensure tab bar is always visible
        tabBar.isHidden = false
        tabBar.isTranslucent = false
        
        // Add shadow
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.1
        tabBar.layer.shadowOffset = CGSize(width: 0, height: -2)
        tabBar.layer.shadowRadius = 4
    }
    
    private func setupViewControllers() {
        let homeVC = MainViewController()
        let homeNav = UINavigationController(rootViewController: homeVC)
        homeNav.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )
        
        let createRecipeVC = CreateRecipeViewController()
        let createRecipeNav = UINavigationController(rootViewController: createRecipeVC)
        createRecipeNav.tabBarItem = UITabBarItem(
            title: "Create recipe",
            image: UIImage(systemName: "plus.circle"),
            selectedImage: UIImage(systemName: "plus.circle.fill")
        )
        
        let profileVC = ProfileViewController()
        let profileNav = UINavigationController(rootViewController: profileVC)
        profileNav.tabBarItem = UITabBarItem(
            title: "My profile",
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person.fill")
        )
        
        viewControllers = [homeNav, createRecipeNav, profileNav]
        
        // Set initial selected tab to profile (index 2)
        selectedIndex = 2
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Ensure tab bar stays at the bottom
        tabBar.frame = CGRect(
            x: 0,
            y: view.frame.height - tabBar.frame.height - view.safeAreaInsets.bottom,
            width: view.frame.width,
            height: tabBar.frame.height
        )
    }
}
