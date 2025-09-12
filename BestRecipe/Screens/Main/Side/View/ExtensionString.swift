//
//  ExtensionString.swift
//  BestRecipe
//
//  Created by iMacbook on 9/6/25.
//

import UIKit

#warning("расширения лучше вынести в отдельную папку Extensions и указывать в названии файла расширяемый тип")
extension String {
    var htmlStripped: String {
        guard let data = self.data(using: .utf8) else { return self }
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        if let attributed = try? NSAttributedString(data: data, options: options, documentAttributes: nil) {
            return attributed.string
        }
        return self
    }
}
