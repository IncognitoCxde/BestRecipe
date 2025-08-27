//
//  CategoryGradient.swift
//  homework
//
//  Created by Zarina Sadykova on 24.08.25.
//

import UIKit

final class GradientOverlayView: UIView {
    
    // MARK: - Properties
    private let gradientLayer = CAGradientLayer()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradient()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradient()
    }
    
    // MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    // MARK: - Private Methods
    private func setupGradient() {
        gradientLayer.colors = [
            UIColor(red: 0, green: 0, blue: 0, alpha: 0.0).cgColor,
            UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor,
            UIColor(red: 0, green: 0, blue: 0, alpha: 0.6).cgColor,
            UIColor(red: 0, green: 0, blue: 0, alpha: 0.9).cgColor
        ]
        
        gradientLayer.locations = [0.0, 0.3, 0.7, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        layer.addSublayer(gradientLayer)
    }
    
    // MARK: - Public Methods
    func updateGradient(colors: [UIColor], locations: [NSNumber]? = nil) {
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.locations = locations
    }
}
