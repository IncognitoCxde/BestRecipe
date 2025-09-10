//
//  SaveButtonExtension.swift
//  BestRecipe
//
//  Created by Irina  on 07/09/25.
//

import UIKit

final class SaveButton: UIButton {
    var recipeID: Int?
    var onToggle: (() -> Void)?

    init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        setImage(UIImage(named: "Bookmark"), for: .normal)
        contentVerticalAlignment = .fill
        contentHorizontalAlignment = .fill
        addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }

    func updateAppearance() {
        guard let id = recipeID else { return }
        let isSaved = SaveManager.shared.isFavorite(id: id)
        let imageName = isSaved ? "BookmarkSelected" : "Bookmark"
        setImage(UIImage(named: imageName), for: .normal)
    }

    @objc private func saveButtonTapped() {
        guard let id = recipeID else { return }
        SaveManager.shared.toggle(id: id)
        updateAppearance()
        onToggle?()
    }
}
