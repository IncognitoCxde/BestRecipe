//
//  NetworkingManager.swift
//  BestRecipe
//
//  Created by iMacbook on 9/3/25.
//

import Foundation

struct NetworkingManager {
    
    func createURL(for endPoint: Endpoint, with query: String? = nil) -> URL? {
        var components = URLComponents()
        components.scheme = API.scheme
        components.host = API.host
        components.path = endPoint.path
        
        components.queryItems = makeParameters(for: endPoint, with: query).map { URLQueryItem(name: $0.key, value: $0.value) }
        
        return components.url
    }
    
    func makeParameters(for endpoint: Endpoint, with query: String?) -> [String: String] {
        var parameters = [String: String]()
        parameters["apiKey"] = API.apiKey
        
        switch endpoint {
        case .trending:
            parameters["number"] = "10"
            parameters["sort"] = "healthiness"
        case .popularRecipes:
            parameters["number"] = "10"
            parameters["sort"] = "popularity"
        case .popularCategories(let category):
            parameters["number"] = "10"
            parameters["type"] = category
        case .search(query: let request):
            parameters["number"] = "10"
            parameters["query"] = request
        case .details(id: let id):
            parameters["id"] = "\(id)"
        }
        return parameters
    }
    
    func makeTask<T: Codable>(for url: URL, apiKey: String, using session: URLSession = .shared, completion: @escaping(Result<T, NetworkError>) -> Void) {
        
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "X-API-KEY")
        
        session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.transportError(error)))
                return
            }
            
            guard response is HTTPURLResponse else {
                let error = NSError(domain: "No HTTP URLResponse", code: 0, userInfo: nil)
                completion(.failure(.serverError(statusCode: error.code)))
                return
            }
            
            guard let data = data else {
                _ =  NSError(domain: "No data", code: 0, userInfo: nil)
                completion(.failure(.noData))
                return
            }
            
            do {
                let decodeData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodeData))
            } catch {
                completion(.failure(.decodingError(error)))
            }
        }.resume()
    }
}
