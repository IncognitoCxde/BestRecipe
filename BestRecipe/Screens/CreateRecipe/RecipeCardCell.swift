import UIKit

final class RecipeCardCell: UICollectionViewCell {
    
    struct ViewModel: Hashable, Sendable {
        let id: UUID
        let title: String
        let cookTimeText: String
        let ingredientsCountText: String
        let imageData: Data?
        
        init(recipe: CreatedRecipe) {
            self.id = recipe.id
            self.title = recipe.title
            self.cookTimeText = recipe.cookTimeText
            self.ingredientsCountText = recipe.ingredientsText
            self.imageData = recipe.imageData
        }
    }
    
    var onDeleteTapped: ((UUID) -> Void)?
    private var currentViewModel: ViewModel?
    
    private let imageView = UIImageView()
    private let gradientLayer = CAGradientLayer()
    private let titleLabel = UILabel()
    private let metaStackView = UIStackView()
    private let ingredientsLabel = UILabel()
    private let timeLabel = UILabel()
    private let ratingContainer = UIView()
    private let starImageView = UIImageView()
    private let ratingLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) { nil }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        titleLabel.text = nil
        ingredientsLabel.text = nil
        timeLabel.text = nil
        currentViewModel = nil
    }
    
    private func setupUI() {
        contentView.backgroundColor = .systemGray6
        contentView.layer.cornerRadius = 16
        contentView.clipsToBounds = true
        
        setupImageView()
        setupLabels()
        setupRatingBadge()
    }
    
    private func setupImageView() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.withAlphaComponent(0.7).cgColor]
        gradientLayer.locations = [0.5, 1.0]
        imageView.layer.addSublayer(gradientLayer)
    }
    
    private func setupLabels() {
        titleLabel.font = UIFont(name: AppFont.SemiBold, size: 16) ?? .systemFont(ofSize: 16, weight: .semibold)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 2
        
        ingredientsLabel.font = UIFont(name: AppFont.Regular, size: 12) ?? .systemFont(ofSize: 12)
        ingredientsLabel.textColor = .white
        
        timeLabel.font = UIFont(name: AppFont.Regular, size: 12) ?? .systemFont(ofSize: 12)
        timeLabel.textColor = .white
        
        metaStackView.axis = .horizontal
        metaStackView.alignment = .center
        metaStackView.spacing = 8
        
        let divider = UIView()
        divider.backgroundColor = UIColor.white.withAlphaComponent(0.6)
        divider.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            divider.widthAnchor.constraint(equalToConstant: 1),
            divider.heightAnchor.constraint(equalToConstant: 12)
        ])
        
        metaStackView.addArrangedSubview(ingredientsLabel)
        metaStackView.addArrangedSubview(divider)
        metaStackView.addArrangedSubview(timeLabel)
    }
    
    private func setupRatingBadge() {
        ratingContainer.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        ratingContainer.layer.cornerRadius = 12
        ratingContainer.clipsToBounds = true
        
        starImageView.image = UIImage(systemName: "star.fill")
        starImageView.tintColor = .white
        
        ratingLabel.text = "5,0"
        ratingLabel.textColor = .white
        ratingLabel.font = UIFont(name: AppFont.SemiBold, size: 12) ?? .systemFont(ofSize: 12, weight: .semibold)
        
        let ratingStack = UIStackView(arrangedSubviews: [starImageView, ratingLabel])
        ratingStack.axis = .horizontal
        ratingStack.spacing = 4
        ratingStack.alignment = .center
        
        ratingContainer.addSubview(ratingStack)
        ratingStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            ratingStack.topAnchor.constraint(equalTo: ratingContainer.topAnchor, constant: 4),
            ratingStack.bottomAnchor.constraint(equalTo: ratingContainer.bottomAnchor, constant: -4),
            ratingStack.leadingAnchor.constraint(equalTo: ratingContainer.leadingAnchor, constant: 8),
            ratingStack.trailingAnchor.constraint(equalTo: ratingContainer.trailingAnchor, constant: -8)
        ])
    }
    
    private func setupConstraints() {
        let components = [imageView, titleLabel, metaStackView, ratingContainer]
        components.forEach { component in
            component.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(component)
        }
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            titleLabel.bottomAnchor.constraint(equalTo: metaStackView.topAnchor, constant: -8),
            
            metaStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            metaStackView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16),
            metaStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            ratingContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            ratingContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8)
        ])
    }
    
    func configure(with viewModel: ViewModel) {
        self.currentViewModel = viewModel
        
        titleLabel.text = viewModel.title
        ingredientsLabel.text = viewModel.ingredientsCountText
        timeLabel.text = viewModel.cookTimeText
        
        if let imageData = viewModel.imageData, let image = UIImage(data: imageData) {
            imageView.image = image
        } else {
            imageView.image = UIImage(named: "placeholder-food")
        }
    }
}

final class PlaceholderCell: UICollectionViewCell {
    
    struct ViewModel: Hashable, Sendable {
        let title: String
        let ctaTitle: String?
    }
    
    var onCTATapped: (() -> Void)?
    
    private let titleLabel = UILabel()
    private let ctaButton = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) { nil }
    
    private func setupUI() {
        contentView.backgroundColor = .clear
        
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: AppFont.Regular, size: 20) ?? .preferredFont(forTextStyle: .title3)
        titleLabel.textColor = .secondaryLabel
        titleLabel.numberOfLines = 0
        
        ctaButton.addTarget(self, action: #selector(ctaButtonTapped), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, ctaButton])
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.alignment = .center
        
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
    func configure(with viewModel: ViewModel) {
        titleLabel.text = viewModel.title
        
        if let ctaTitle = viewModel.ctaTitle {
            ctaButton.setTitle(ctaTitle, for: .normal)
            ctaButton.isHidden = false
        } else {
            ctaButton.isHidden = true
        }
    }
    
    @objc private func ctaButtonTapped() {
        onCTATapped?()
    }
}
