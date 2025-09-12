//
//  Storage.swift
//  homework
//
//  Created by Zarina Sadykova on 23.08.25.
//

import UIKit

protocol OnboardingStorageProtocol {
    var hasSeenOnboarding: Bool { get set }
}

final class OnboardingStorage: OnboardingStorageProtocol {
    static let shared = OnboardingStorage()
    private let key = "hasSeenOnboarding"
    
    var hasSeenOnboarding: Bool {
        get {
            let value = UserDefaults.standard.bool(forKey: key)
            print("🔍 Reading hasSeenOnboarding: \(value)")
            return value
        }
        set {
            print("📞 Setting hasSeenOnboarding: \(newValue)")
            UserDefaults.standard.set(newValue, forKey: key)
            UserDefaults.standard.synchronize()
#warning("Apple не рекомендует использовать UserDefaults.standard.synchronize()")
        }
    }
    
    // Для отладки
    func printStatus() {
        print("📞 Current hasSeenOnboarding status: \(hasSeenOnboarding)")
    }
}
