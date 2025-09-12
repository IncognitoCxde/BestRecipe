//
//  OnboardingPage.swift
//  homework
//
//  Created by Zarina Sadykova on 22.08.25.
//

import Foundation


struct OnboardingPage {
    let title: String
    let subtitle: String
    let imageName: String
}

final class OnboardingViewModel {
    let pages: [OnboardingPage]
    var storage: OnboardingStorageProtocol
    
    var currentIndex: Int = 0 {
        didSet { onPageChanged?(currentIndex) }
    }
    
    // Callbacks
    var onPageChanged: ((Int) -> Void)?
    var onFinish: (() -> Void)?
    
    init(storage: OnboardingStorageProtocol = OnboardingStorage()) {
        self.storage = storage
        self.pages = [
            .init(title: "Recipes from\nall over the\nWorld",
                  subtitle: "",
                  imageName: "onboarding2"),
            .init(title: "Recipes with\n each and every detail",
                  subtitle: "",
                  imageName: "onboarding3"),
            .init(title: "Cook it now or \nsave it for later",
                  subtitle: "",
                  imageName: "onboarding4")
        ]
#warning("зачем нужен subtitle, если он всегда пустой?")
    }
    
    var isLastPage: Bool { currentIndex == pages.count - 1 }
    
    func next() {
        guard currentIndex + 1 < pages.count else { return }
        currentIndex += 1
    }
    
    func skip() {
        finish()
    }
    
    func finish() {
        print("OnboardingViewModel.finish() called")
        storage.hasSeenOnboarding = true // ← ✅ Это должно быть true
        print("Set hasSeenOnboarding to true")
        onFinish?()
    }

}
