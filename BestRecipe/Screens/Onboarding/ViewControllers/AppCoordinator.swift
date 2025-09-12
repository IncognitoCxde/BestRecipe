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

    // отличный инит! Great job!
    init(window: UIWindow, storage: OnboardingStorageProtocol) {
        self.window = window
        self.storage = storage
        print("AppCoordinator: инициализирован")
        // принт вряд ли нужен
    }

    func start() {
//        print("AppCoordinator: start()")
//        print("🔍 Текущее значение hasSeenOnboarding: \(storage.hasSeenOnboarding)")
//        
//        if storage.hasSeenOnboarding {
//            print("AppCoordinator: hasSeenOnboarding = true, переходим на Home")
//            showHome()
//        } else {
//            print("AppCoordinator: hasSeenOnboarding = false, показываем Hello")
            showHello()
//        }
        
        window.makeKeyAndVisible()
        print("AppCoordinator: start() завершен.")
    }

    func showHello() {
        print("Coordinator: showHello()")
        let helloViewModel = HelloViewModel()
        let helloViewController = HelloViewController(viewModel: helloViewModel)
        
        helloViewModel.onContinue = { [weak self] in
            print("Coordinator: Замыкание helloViewModel.onContinue вызвано")
            self?.showOnboarding()
        }
        
        navigationController = UINavigationController(rootViewController: helloViewController)
        navigationController?.isNavigationBarHidden = true
        window.rootViewController = navigationController
    }

    private func showOnboarding() {
        print("Coordinator: showOnboarding()")
        let onboardingViewModel = OnboardingViewModel(storage: storage)
        
        // ✅ Используем правильный OnboardingViewController
        let onboardingViewController = OnboardingViewController(viewModel: onboardingViewModel)
        
        onboardingViewModel.onFinish = { [weak self] in
            print("Coordinator: Замыкание onboardingViewModel.onFinish вызвано")
            self?.showHome()
        }

        // ✅ Просто заменяем rootViewController
        window.rootViewController = onboardingViewController
    }

    private func showHome() {
        print("Coordinator: showHome()")
        let CustomTabBar = CustomTabBarController()
        let navController = UINavigationController(rootViewController: CustomTabBar)

        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.window.rootViewController = navController
        }, completion: { _ in
            print("Coordinator: Успешно перешли на MainViewController.")
        })
    }
}
