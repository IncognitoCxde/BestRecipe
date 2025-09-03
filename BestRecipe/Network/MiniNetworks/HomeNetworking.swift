//
//  HomeNetworking.swift
//  BestRecipe
//
//  Created by iMacbook on 9/3/25.
//

import UIKit

protocol HomeNetworkingProtocol {
    func fetchTrending(completion: @escaping ((Result<[Recipe], NetworkError>) -> Void))
    func fetchPopularCategories(_ category: String, completion: @escaping ((Result<[Recipe], NetworkError>) -> Void))
    func fetchPopular(completion: @escaping ((Result<[Recipe], NetworkError>) -> Void))
    func fetchRecent(completion: @escaping ((Result<[Recipe], NetworkError>) -> Void))
}

final class HomeNetworkingManager: HomeNetworkingProtocol {
    
    let manager = NetworkingManager()
    
    func fetchTrending(completion: @escaping (Result<[Recipe], NetworkError>) -> Void) {
        guard let url = manager.createURL(for: .trending) else { return }
        manager.makeTask(for: url, apiKey: API.apiKey, completion: completion)
    }
    
    func fetchPopularCategories(_ category: String, completion: @escaping (Result<[Recipe], NetworkError>) -> Void) {
        guard let url = manager.createURL(for: .popularCategories(category: category)) else { return }
        manager.makeTask(for: url, apiKey: API.apiKey, completion: completion)
    }
    
    func fetchPopular(completion: @escaping (Result<[Recipe], NetworkError>) -> Void) {
        guard let url = manager.createURL(for: .popularRecipes) else { return }
        manager.makeTask(for: url, apiKey: API.apiKey, completion: completion)
    }
    
    func fetchRecent(completion: @escaping (Result<[Recipe], NetworkError>) -> Void) {
        guard let url = manager.createURL(for: .recent) else { return }
        manager.makeTask(for: url, apiKey: API.apiKey, completion: completion)
    }
    
}
