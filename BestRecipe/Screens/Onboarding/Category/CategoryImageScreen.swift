//
//  CategoryImageScreen.swift
//  homework
//
//  Created by Zarina Sadykova on 22.08.25.
//

import UIKit
import SnapKit

#warning("не совсем понятно, что это")
private let kOverlayTag = 999_001
private let kBlurTag    = 999_002

class BackgroundImageView: UIImageView {

    // MARK: - Initialization
    convenience init(imageName: String, contentMode: ContentMode = .scaleAspectFill) {
        self.init(frame: .zero)
        self.image = UIImage(named: imageName)
        self.contentMode = contentMode
        setupImageView()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupImageView()
    }
    
    // MARK: - Configuration
    private func setupImageView() {
        clipsToBounds = true
        isUserInteractionEnabled = false
        contentMode = .scaleAspectFill
    }
    
    // MARK: - Public Methods
    func setImage(named imageName: String) {
        self.image = UIImage(named: imageName)
    }
    
    func applyBlurEffect(style: UIBlurEffect.Style = .light, alpha: CGFloat = 0.8) {
        if viewWithTag(kBlurTag) != nil { return }
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = alpha
        blurEffectView.tag = kBlurTag
        addSubview(blurEffectView)
        blurEffectView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    func applyDarkOverlay(alpha: CGFloat = 0.45) {
        if viewWithTag(kOverlayTag) != nil { return }
        let overlayView = UIView()
        overlayView.tag = kOverlayTag
        overlayView.backgroundColor = .black
        overlayView.alpha = alpha
        addSubview(overlayView)
        overlayView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    // MARK: - Layout Helpers
    func pinToSuperview() {
        guard superview != nil else { return }
        snp.makeConstraints { make in make.edges.equalToSuperview() }
    }
    
    func pinToSuperview(with insets: UIEdgeInsets) {
        guard let superview else { return }
        snp.makeConstraints { make in
            make.top.equalTo(superview).offset(insets.top)
            make.leading.equalTo(superview).offset(insets.left)
            make.trailing.equalTo(superview).offset(-insets.right)
            make.bottom.equalTo(superview).offset(-insets.bottom)
        }
    }
}

extension BackgroundImageView {
    static func createBackground(with imageName: String) -> BackgroundImageView {
        BackgroundImageView(imageName: imageName)
    }
}
