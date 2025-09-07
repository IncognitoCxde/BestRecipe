//
//  Structure.swift
//  BestRecipe
//
//  Created by Zarina Sadykova on 03.09.25.
//

import UIKit

struct RegistrationFieldConfig {
    let title: String
    let placeholder: String
    let isSecure: Bool
    let keyboardType: UIKeyboardType
}


//ошибки валидации
enum ValidationError: LocalizedError {
    case emptyField(field: String, index: Int)
    case invalidFirstName(index: Int)
    case invalidLastName(index: Int)
    case invalidEmail(index: Int)
    case invalidPassword(index: Int)
    case passwordsDoNotMatch(index: Int)

    var fieldIndex: Int {
        switch self {
        case .emptyField(_, let index): return index
        case .invalidFirstName(let index): return index
        case .invalidLastName(let index): return index
        case .invalidEmail(let index): return index
        case .invalidPassword(let index): return index
        case .passwordsDoNotMatch(let index): return index
        }
    }

    var errorDescription: String? {
        switch self {
        case .emptyField(let field, _):
            return "\(field) is required"
        case .invalidFirstName:
            return "First Name must be 2–15 latin characters"
        case .invalidLastName:
            return "Last Name must be 2–15 latin characters"
        case .invalidEmail:
            return "Invalid email format"
        case .invalidPassword:
            return "Password must be 6–10 chars, include 1 digit, 1 special symbol"
        case .passwordsDoNotMatch:
            return "Passwords do not match"
        }
    }
}
