

import UIKit

extension UIImageView {
    func loadImage(from imageName: String, size: String = "100x100") {
#warning("это было бы хорошо оформить внутри Networking Manager")
#warning("в целом, extension UIImageView не очень подходит для этой логики")
        let baseURL = "https://img.spoonacular.com/ingredients_\(size)/"
        guard let url = URL(string: baseURL + imageName) else {
            DispatchQueue.main.async {
                self.image = nil
            }
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data, error == nil, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
            } else {
                DispatchQueue.main.async {
                    self.image = nil
                }
            }
        }.resume()
    }
}
