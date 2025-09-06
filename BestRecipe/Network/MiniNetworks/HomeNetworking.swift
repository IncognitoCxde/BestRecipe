//
//  HomeNetworking.swift
//  BestRecipe
//
//  Created by iMacbook on 9/3/25.
//

import UIKit

protocol HomeNetworkingProtocol {
    func fetchTrending(completion: @escaping ((Result<RecipesResponse, NetworkError>) -> Void))
    func fetchRecipesByPopularCategory(for category: Categories, completion: @escaping (Result<RecipesResponse, NetworkError>) -> Void)
    func fetchPopular(completion: @escaping ((Result<RecipesResponse, NetworkError>) -> Void))
    func fetchRecipeDetail(id: Int, completion: @escaping (Result<RecipeDetail, NetworkError>) -> Void)}

final class HomeNetworkingManager: HomeNetworkingProtocol {
    
    let manager = NetworkingManager()
    
    func fetchTrending(completion: @escaping (Result<RecipesResponse, NetworkError>) -> Void) {
        guard let url = manager.createURL(for: .trending) else { return }
        manager.makeTask(for: url, apiKey: API.apiKey, completion: completion)
    }
    
    func fetchRecipesByPopularCategory(for category: Categories, completion: @escaping (Result<RecipesResponse, NetworkError>) -> Void) {
        guard let url = manager.createURL(for: .popularCategories(category: Categories.RawValue(category.rawValue))) else { return }
        manager.makeTask(for: url, apiKey: API.apiKey, completion: completion)
    }
    
    func fetchPopular(completion: @escaping (Result<RecipesResponse, NetworkError>) -> Void) {
        guard let url = manager.createURL(for: .popularRecipes) else { return }
        manager.makeTask(for: url, apiKey: API.apiKey, completion: completion)
    }
    
    func fetchRecipeDetail(id: Int, completion: @escaping (Result<RecipeDetail, NetworkError>) -> Void) {
        guard let url = manager.createURL(for: .details(id: id)) else { return }
        manager.makeTask(for: url, apiKey: API.apiKey, completion: completion)
    }
    
    
    
}
