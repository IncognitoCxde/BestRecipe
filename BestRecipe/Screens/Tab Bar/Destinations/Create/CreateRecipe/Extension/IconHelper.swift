import UIKit

// MARK: - Custom Icons
extension UIImage {
    
    // MARK: - Recipe Icons (Only these two are custom)
    static let ClockIcon = UIImage(named: "ClockIcon")
    static let PersonIcon = UIImage(named: "PersonIcon")
    
    // MARK: - Action Icons (Add these two)
    static let plusIcon = UIImage(named: "Plus-Border")
    static let minusIcon = UIImage(named: "Minus-Border")
    
    // MARK: - Fallback to System Icons (for all other icons)
    static let clockIconFallback = UIImage(systemName: "clock")
    static let personIconFallback = UIImage(systemName: "person.2")
    static let plusIconFallback = UIImage(systemName: "plus")
    static let minusIconFallback = UIImage(systemName: "minus")
}

// MARK: - Icon Helper
struct IconHelper {
    
    // Get custom icon or fallback to system icon
    static func getIcon(_ customIcon: UIImage?, fallback: UIImage?) -> UIImage? {
        return customIcon ?? fallback
    }
    
    // Configure tab bar item with custom icon
    static func configureTabBarItem(_ item: UITabBarItem, customIcon: UIImage?, fallback: UIImage?, title: String) {
        item.image = getIcon(customIcon, fallback: fallback)
        item.title = title
    }
}
