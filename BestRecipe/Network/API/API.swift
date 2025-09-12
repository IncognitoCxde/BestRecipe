
// https://api.spoonacular.com

#warning("здесь нет UI элементов чтобы импортить UIKit")
import Foundation

struct API {
    static let scheme = "https"
    static let host = "api.spoonacular.com"
    static let apiKey = Token.first
}

struct Token {
    static let first = "977e7847d283492bb87bffe3d7256e12"
    static let second = "952db1e593eb49fabc3c7db2bbf382f3"
    static let third = "651ec0da730e44c6a02c07e9abb888c3"
    static let fourth = "2415ef7c13274f62940b3053e241d579"
}
