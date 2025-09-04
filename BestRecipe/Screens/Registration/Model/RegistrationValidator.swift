//
//  RegistrationValidator.swift
//  BestRecipe
//
//  Created by Zarina Sadykova on 03.09.25.
//
import UIKit

struct RegistrationValidator {
    
    static func validate(fields: [String], fieldTitles: [String]) -> ValidationError? {
        for (index, value) in fields.enumerated() {
            if value.isEmpty {
                return .emptyField(field: fieldTitles[index], index: index)
            }
        }
        
        let firstName = fields[0]
        let lastName = fields[1]
        let email = fields[2]
        let password = fields[3]
        let confirmPassword = fields[4]
        
        let nameRegex = "^[A-Za-z]{2,15}$"
        if !NSPredicate(format: "SELF MATCHES %@", nameRegex).evaluate(with: firstName) {
            return .invalidFirstName(index: 0)
        }
        if !NSPredicate(format: "SELF MATCHES %@", nameRegex).evaluate(with: lastName) {
            return .invalidLastName(index: 1)
        }
        
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        if !NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email) {
            return .invalidEmail(index: 2)
        }
        
        let passwordRegex = "^(?=.*[0-9])(?=.*[!@#$%^&*])[A-Za-z0-9!@#$%^&*]{6,10}$"
        if !NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password) {
            return .invalidPassword(index: 3)
        }
        
        if password != confirmPassword {
            return .passwordsDoNotMatch(index: 4)
        }
        
        return nil
    }
}
