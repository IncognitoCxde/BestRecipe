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
    static let apiKey = Token.fourth
}

struct Token {
    static let first = "f566cb6be12b4681a12472763f12db1b"
    static let second = "af8edef3a32c4adbac65b8c283475508"
    static let third = "651ec0da730e44c6a02c07e9abb888c3"
    static let fourth = "2415ef7c13274f62940b3053e241d579"
}
