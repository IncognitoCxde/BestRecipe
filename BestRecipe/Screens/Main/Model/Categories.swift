//
//  Categories.swift
//  BestRecipe
//
//  Created by iMacbook on 9/10/25.
//


enum Categories: String, Equatable {
    case salad = "salad"
    case appetizer = "appetizer"
    case mainCourse = "main course"
    case sideDish = "side dish"
    case dessert = "dessert"
    case breakfast = "breakfast"
    case beverage = "beverage"
    
    var stringValue: String {
        rawValue
    }
}
