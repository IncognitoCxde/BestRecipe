//
//  API.swift
//  BestRecipe
//
//  Created by iMacbook on 9/1/25.
//
// https://api.spoonacular.com

import UIKit

struct API {
    static let scheme = "https"
    static let host = "api.spoonacular.com"
    static let apiKey = Token.second
}

struct Token {
    static let first = "2c3d6fb8e3a4445883fbf80d4d9cadee"
    static let second = "952db1e593eb49fabc3c7db2bbf382f3"
    static let third = "68711ec5f107405ea92429db31d7700c"
    static let fourth = "2415ef7c13274f62940b3053e241d579"
}
