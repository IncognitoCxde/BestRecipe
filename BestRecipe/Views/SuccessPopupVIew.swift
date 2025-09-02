import UIKit

final class SuccessPopupView: UIView {
    
    var onViewRecipesTapped: (() -> Void)?
    
    private let containerView = UIView()
    private let checkmarkImageView = UIImageView()
    private let titleLabel = UILabel()
    private let viewRecipesButton = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) { nil }
    
    private func setupUI() {
        backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        containerView.backgroundColor = .systemBackground
        containerView.layer.cornerRadius = 16
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.2
        containerView.layer.shadowOffset = CGSize(width: 0, height: 4)
        containerView.layer.shadowRadius = 12
        
        checkmarkImageView.image = UIImage(systemName: "checkmark.circle.fill")
        checkmarkImageView.tintColor = .systemGreen
        checkmarkImageView.contentMode = .scaleAspectFit
        
        titleLabel.text = "Your recipe has been successfully created"
        titleLabel.font = UIFont(name: AppFont.SemiBold, size: 18) ?? .systemFont(ofSize: 18, weight: .semibold)
        titleLabel.textColor = .label
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        
        viewRecipesButton.setTitle("My Recipes", for: .normal)
        viewRecipesButton.backgroundColor = .systemGreen
        viewRecipesButton.setTitleColor(.white, for: .normal)
        viewRecipesButton.titleLabel?.font = UIFont(name: AppFont.SemiBold, size: 16) ?? .systemFont(ofSize: 16, weight: .semibold)
        viewRecipesButton.layer.cornerRadius = 8
        viewRecipesButton.addTarget(self, action: #selector(viewRecipesTapped), for: .touchUpInside)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))
        addGestureRecognizer(tapGesture)
    }
    
    private func setupConstraints() {
        addSubview(containerView)
        containerView.addSubview(checkmarkImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(viewRecipesButton)
        
        [containerView, checkmarkImageView, titleLabel, viewRecipesButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 240),
            
            checkmarkImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 24),
            checkmarkImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            checkmarkImageView.widthAnchor.constraint(equalToConstant: 60),
            checkmarkImageView.heightAnchor.constraint(equalToConstant: 60),
            
            titleLabel.topAnchor.constraint(equalTo: checkmarkImageView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            
            viewRecipesButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            viewRecipesButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            viewRecipesButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            viewRecipesButton.heightAnchor.constraint(equalToConstant: 44),
            viewRecipesButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)
        ])
    }
    
    @objc private func viewRecipesTapped() {
        onViewRecipesTapped?()
    }
    
    @objc private func backgroundTapped() {
        removeFromSuperview()
    }
    
    func show(in view: UIView) {
        view.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor),
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        alpha = 0
        containerView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut) {
            self.alpha = 1
            self.containerView.transform = .identity
        }
    }
    
    func hide() {
        UIView.animate(withDuration: 0.2) {
            self.alpha = 0
            self.containerView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        } completion: { _ in
            self.removeFromSuperview()
        }
    }
}
