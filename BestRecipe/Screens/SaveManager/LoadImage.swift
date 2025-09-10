//
//  LoadImage.swift
//  BestRecipe
//
//  Created by Irina  on 07/09/25.
//

import UIKit

class ImageLoader {
    static let shared = ImageLoader()
    private let cache = NSCache<NSURL, UIImage>()
    
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        if let cached = cache.object(forKey: url as NSURL) {
            completion(cached)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, let image = UIImage(data: data), error == nil else {
                completion(nil)
                return
            }
            self.cache.setObject(image, forKey: url as NSURL)
            completion(image)
        }.resume()
    }
}
