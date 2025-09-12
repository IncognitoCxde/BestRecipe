//
//  SceneDelegate.swift
//  BestRecipe
//
//  Created by iMacbook on 8/15/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: AppCoordinator?
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        print("SceneDelegate: scene(_:willConnectTo:options:) запущен")
        
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        
        let storage = OnboardingStorage.shared
        
        print("SceneDelegate: OnboardingStorage создан")

        coordinator = AppCoordinator(window: window, storage: storage)
        print("SceneDelegate: AppCoordinator инициализирован")
        
        coordinator?.start()
        print("SceneDelegate: coordinator?.start() вызван. Окно должно быть видно.")

        #warning("это бесполезные принты, которые выполнятся в любом случае")
    }

    // это можно удалить
    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }


}

