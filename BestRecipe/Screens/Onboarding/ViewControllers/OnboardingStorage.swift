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
            return value
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
            UserDefaults.standard.synchronize()
        }
    }
}
