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
    static let apiKey = Token.first
}

struct Token {
    static let first = "0fcf97413d184e4794cd2839b1d6f648"
    static let second = "952db1e593eb49fabc3c7db2bbf382f3"
    static let third = "651ec0da730e44c6a02c07e9abb888c3"
    static let fourth = "2415ef7c13274f62940b3053e241d579"
}
