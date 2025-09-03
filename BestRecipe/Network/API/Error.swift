//
//  Error.swift
//  BestRecipe
//
//  Created by iMacbook on 9/3/25.
//

import Foundation

enum NetworkError: Error {
    case transportError(Error)
    case decodingError(Error)
    case noData
    case serverError(statusCode: Int)
}
