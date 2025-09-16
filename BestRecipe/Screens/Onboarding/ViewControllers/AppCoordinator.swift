//
//  AppCoordinator 2.swift
//  homework
//
//  Created by Zarina Sadykova on 23.08.25.
//
import UIKit

final class AppCoordinator {
    private let window: UIWindow
    private let storage: OnboardingStorageProtocol
    var navigationController: UINavigationController?

    init(window: UIWindow, storage: OnboardingStorageProtocol) {
        self.window = window
        self.storage = storage
    }

    func start() {
        if storage.hasSeenOnboarding {
            showRegistration()
        } else {
            showHello()
        }
        
        window.makeKeyAndVisible()
    }

    func showHello() {
        let helloViewModel = HelloViewModel()
        let helloViewController = HelloViewController(viewModel: helloViewModel)
        
        helloViewModel.onContinue = { [weak self] in
            self?.showOnboarding()
        }
        
        navigationController = UINavigationController(rootViewController: helloViewController)
        navigationController?.isNavigationBarHidden = true
        window.rootViewController = navigationController
    }

    private func showOnboarding() {
        let onboardingViewModel = OnboardingViewModel(storage: storage)
        
        let onboardingViewController = OnboardingViewController(viewModel: onboardingViewModel)
        
        onboardingViewModel.onFinish = { [weak self] in
            self?.showRegistration()
        }

        window.rootViewController = onboardingViewController
    }

    private func showRegistration() {
        let registrationViewController = LoginViewController()
        let navController = UINavigationController(rootViewController: registrationViewController)
        navController.isNavigationBarHidden = true

        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.window.rootViewController = navController
        }, completion: { _ in
        })
    }
}

