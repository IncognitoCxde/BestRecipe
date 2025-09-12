
import UIKit

#warning("непонятное название + файл должен быть в DesignSystem")
class CustomButton: UIButton {

    // MARK: - Public Properties
    var customCornerRadius: CGFloat = 12 {
        didSet {
            layer.cornerRadius = customCornerRadius
        }
    }
    
    // MARK: - Initialization
#warning("это можно в обычный инит, тут не нужен convenience")
    convenience init(title: String, cornerRadius: CGFloat = 12) {
        self.init(frame: .zero)
        setTitle(title, for: .normal)
        self.customCornerRadius = cornerRadius
        setupButton()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    // MARK: - Configuration
    private func setupButton() {
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont(name: AppFont.SemiBold, size: 20)
        titleLabel?.adjustsFontSizeToFitWidth = false
        titleLabel?.minimumScaleFactor = 1.0
        titleLabel?.lineBreakMode = .byClipping
        backgroundColor = .primary50
        layer.cornerRadius = customCornerRadius
        layer.masksToBounds = true
    }
    
   
    // MARK: - Public Methods
    func setCornerRadius(_ radius: CGFloat) {
        customCornerRadius = radius
        layer.cornerRadius = radius
    }
}

