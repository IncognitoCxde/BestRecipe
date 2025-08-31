//
//  Router.swift
//  BestRecipe
//
//  Created by iMacbook on 8/31/25.
//

import UIKit

final class Router {
    private let window: UIWindow?
    private let coordinator: AppCoordinator?
    let storage = OnboardingStorage.shared
    
    init(window: UIWindow?, coordinator: AppCoordinator?) {
        self.window = window
        self.coordinator = coordinator
    }
    
    func start() {
        let viewModel = HelloViewModel()
        let onboardingViewModel = OnboardingViewModel()
        let helloVC = HelloViewController(viewModel: viewModel)
    
        
        if storage.hasSeenOnboarding == false {
            window?.rootViewController = helloVC
            viewModel.continueToOnboarding()
            onboardingViewModel.finish()
        }
        
    }
    
    func showTabBar() {
        window?.rootViewController = CustomTabBarController()
    }
    
}
