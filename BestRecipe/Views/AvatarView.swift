import UIKit

final class AvatarView: UIView {
    
    private let imageView = UIImageView()
    private let initialsLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) { nil }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = min(bounds.width, bounds.height) / 2
    }
    
    private func setupUI() {
        clipsToBounds = true
        backgroundColor = .systemGray4
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        initialsLabel.textAlignment = .center
        initialsLabel.font = .preferredFont(forTextStyle: .title2)
        initialsLabel.textColor = .white
        

    }
    
    private func setupConstraints() {
        [imageView, initialsLabel].forEach { component in
            component.translatesAutoresizingMaskIntoConstraints = false
            addSubview(component)
        }
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            initialsLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            initialsLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func setImage(_ image: UIImage?) {
        imageView.image = image
        initialsLabel.isHidden = image != nil
    }
    
    func setInitials(_ text: String) {
        initialsLabel.text = text
        initialsLabel.isHidden = false
    }
}
