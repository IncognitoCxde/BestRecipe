//
//  MainViewController.swift
//  homework
//
//  Created by Zarina Sadykova on 22.08.25.
//
import UIKit

final class HomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Home"
        
        let label = UILabel()
        label.text = "🍳 Home Screen"
        label.font = .Bold(size: 24)
        label.textAlignment = .center
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    // В HomeViewController
    @objc private func resetOnboarding() {
        UserDefaults.standard.removeObject(forKey: "hasSeenOnboarding")
        UserDefaults.standard.synchronize()
        print("🔄 Онбординг сброшен")
        
        // Перезапуск
        if let window = view.window {
            let storage = OnboardingStorage()
            let coordinator = AppCoordinator(window: window, storage: storage)
            coordinator.start()
        }
    }
}
