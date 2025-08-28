//
//  HelloViewModel.swift
//  homework
//
//  Created by Zarina Sadykova on 23.08.25.
//

import Foundation

final class HelloViewModel {
    var onContinue: (() -> Void)?
    func continueToOnboarding() {
        print("HelloViewModel: continueToOnboarding() вызван")
        onContinue?()
    }
}
