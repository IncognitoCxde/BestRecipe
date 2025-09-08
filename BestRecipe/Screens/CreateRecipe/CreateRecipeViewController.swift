import UIKit
import PhotosUI

final class CreateRecipeViewController: UIViewController {
    
    private let viewModel: CreateRecipeViewModel
    private let persistenceService: PersistenceService
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    // Navigation
    private let backButton = UIButton(type: .system)
    private let optionsButton = UIButton(type: .system)
    private let titleLabel = UILabel()
    
    // Image section
    private let imageContainer = UIView()
    private let imageView = UIImageView()
    private let imageEditButton = UIButton(type: .system)
    
    // Title field
    private let titleField = UITextField()
    
    // Serves and Cook Time
    private let servesContainer = UIView()
    private let servesIcon = UIImageView()
    private let servesTitleLabel = UILabel()
    private let servesValueLabel = UILabel()
    private let servesChevron = UIImageView(image: UIImage(systemName: "chevron.right"))
    
    private let cookTimeContainer = UIView()
    private let cookTimeIcon = UIImageView()
    private let cookTimeTitleLabel = UILabel()
    private let cookTimeValueLabel = UILabel()
    private let cookTimeChevron = UIImageView(image: UIImage(systemName: "chevron.right"))
    
    // Ingredients section
    private let ingredientsTitleLabel = UILabel()
    private let ingredientsStackView = UIStackView()
    private let addIngredientButton = UIButton(type: .system)
    
    // Create button
    private let createButton = UIButton(type: .system)
    
    init(viewModel: CreateRecipeViewModel = CreateRecipeViewModel(), persistenceService: PersistenceService = InMemoryPersistenceService.shared) {
        self.viewModel = viewModel
        self.persistenceService = persistenceService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .none
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        setupScrollView()
        setupNavigation()
        setupImageSection()
        setupTitleField()
        setupServesAndCookTime()
        setupIngredientsSection()
        setupCreateButton()
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func setupNavigation() {
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.tintColor = .label
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        
        optionsButton.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        optionsButton.tintColor = .label
        
        titleLabel.text = "Create Recipe"
        titleLabel.font = UIFont(name: AppFont.SemiBold, size: 24) ?? .systemFont(ofSize: 24, weight: .semibold)
        titleLabel.textColor = .label
        
        contentView.addSubview(backButton)
        contentView.addSubview(optionsButton)
        contentView.addSubview(titleLabel)
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        optionsButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            backButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            backButton.widthAnchor.constraint(equalToConstant: 44),
            backButton.heightAnchor.constraint(equalToConstant: 44),
            
            optionsButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            optionsButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            optionsButton.widthAnchor.constraint(equalToConstant: 44),
            optionsButton.heightAnchor.constraint(equalToConstant: 44),
            
            titleLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupImageSection() {
        imageContainer.backgroundColor = .systemGray5
        imageContainer.layer.cornerRadius = 12
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        
        // Круглая иконка добавления фото (карандаш)
        imageEditButton.setImage(UIImage(systemName: "pencil"), for: .normal)
        imageEditButton.backgroundColor = .white
        imageEditButton.layer.cornerRadius = 20
        imageEditButton.layer.shadowColor = UIColor.black.cgColor
        imageEditButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        imageEditButton.layer.shadowOpacity = 0.1
        imageEditButton.layer.shadowRadius = 4
        imageEditButton.tintColor = .black
        imageEditButton.addTarget(self, action: #selector(imageEditTapped), for: .touchUpInside)
        
        contentView.addSubview(imageContainer)
        imageContainer.addSubview(imageView)
        imageContainer.addSubview(imageEditButton)
        
        imageContainer.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageEditButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageContainer.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            imageContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            imageContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            imageContainer.heightAnchor.constraint(equalToConstant: 200),
            
            imageView.topAnchor.constraint(equalTo: imageContainer.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: imageContainer.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: imageContainer.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: imageContainer.bottomAnchor),
            
            imageEditButton.trailingAnchor.constraint(equalTo: imageContainer.trailingAnchor, constant: -16),
            imageEditButton.topAnchor.constraint(equalTo: imageContainer.topAnchor, constant: 16),
            imageEditButton.widthAnchor.constraint(equalToConstant: 40),
            imageEditButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupTitleField() {
        titleField.placeholder = "Recipe title"
        titleField.font = UIFont(name: AppFont.Regular, size: 16) ?? .systemFont(ofSize: 16)
        titleField.borderStyle = .none
        titleField.backgroundColor = .clear
        titleField.layer.cornerRadius = 10
        titleField.layer.borderWidth = 1
        titleField.layer.borderColor = UIColor.systemGray4.cgColor
        titleField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        titleField.leftViewMode = .always
        
        contentView.addSubview(titleField)
        
        titleField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleField.topAnchor.constraint(equalTo: imageContainer.bottomAnchor, constant: 16),
            titleField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            titleField.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func setupServesAndCookTime() {
        servesContainer.backgroundColor = UIColor(red: 0.945, green: 0.945, blue: 0.945, alpha: 1.0) // #F1F1F1
        servesContainer.layer.cornerRadius = 12
        
        servesIcon.image = UIImage(named: "PersonIcon")
        servesIcon.contentMode = .scaleAspectFit
        servesIcon.tintColor = .systemGray
        
        servesTitleLabel.text = "Serves"
        servesTitleLabel.font = UIFont(name: AppFont.SemiBold, size: 16) ?? .systemFont(ofSize: 16, weight: .semibold)
        servesTitleLabel.textColor = .label
        
        servesValueLabel.text = "2 people"
        servesValueLabel.font = UIFont(name: AppFont.Regular, size: 16) ?? .systemFont(ofSize: 16)
        servesValueLabel.textColor = .secondaryLabel
        
        servesChevron.tintColor = .systemGray
        servesChevron.contentMode = .scaleAspectFit
        
        let servesTap = UITapGestureRecognizer(target: self, action: #selector(servesTapped))
        servesContainer.addGestureRecognizer(servesTap)
        servesContainer.isUserInteractionEnabled = true
        
        cookTimeContainer.backgroundColor = UIColor(red: 0.945, green: 0.945, blue: 0.945, alpha: 1.0) // #F1F1F1
        cookTimeContainer.layer.cornerRadius = 12
        
        cookTimeIcon.image = UIImage(named: "ClockIcon")
        cookTimeIcon.contentMode = .scaleAspectFit
        cookTimeIcon.tintColor = .systemGray
        
        cookTimeTitleLabel.text = "Cook Time"
        cookTimeTitleLabel.font = UIFont(name: AppFont.SemiBold, size: 16) ?? .systemFont(ofSize: 16, weight: .semibold)
        cookTimeTitleLabel.textColor = .label
        
        cookTimeValueLabel.text = "10 min"
        cookTimeValueLabel.font = UIFont(name: AppFont.Regular, size: 16) ?? .systemFont(ofSize: 16)
        cookTimeValueLabel.textColor = .secondaryLabel
        
        cookTimeChevron.tintColor = .systemGray
        cookTimeChevron.contentMode = .scaleAspectFit
        
        let cookTimeTap = UITapGestureRecognizer(target: self, action: #selector(cookTimeTapped))
        cookTimeContainer.addGestureRecognizer(cookTimeTap)
        cookTimeContainer.isUserInteractionEnabled = true
        
        contentView.addSubview(servesContainer)
        contentView.addSubview(cookTimeContainer)
        
        servesContainer.addSubview(servesIcon)
        servesContainer.addSubview(servesTitleLabel)
        servesContainer.addSubview(servesValueLabel)
        servesContainer.addSubview(servesChevron)
        
        cookTimeContainer.addSubview(cookTimeIcon)
        cookTimeContainer.addSubview(cookTimeTitleLabel)
        cookTimeContainer.addSubview(cookTimeValueLabel)
        cookTimeContainer.addSubview(cookTimeChevron)
        
        servesContainer.translatesAutoresizingMaskIntoConstraints = false
        cookTimeContainer.translatesAutoresizingMaskIntoConstraints = false
        servesIcon.translatesAutoresizingMaskIntoConstraints = false
        servesTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        servesValueLabel.translatesAutoresizingMaskIntoConstraints = false
        servesChevron.translatesAutoresizingMaskIntoConstraints = false
        cookTimeIcon.translatesAutoresizingMaskIntoConstraints = false
        cookTimeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        cookTimeValueLabel.translatesAutoresizingMaskIntoConstraints = false
        cookTimeChevron.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            servesContainer.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: 16),
            servesContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            servesContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            servesContainer.heightAnchor.constraint(equalToConstant: 60),
            
            servesIcon.leadingAnchor.constraint(equalTo: servesContainer.leadingAnchor, constant: 16),
            servesIcon.centerYAnchor.constraint(equalTo: servesContainer.centerYAnchor),
            servesIcon.widthAnchor.constraint(equalToConstant: 24),
            servesIcon.heightAnchor.constraint(equalToConstant: 24),
            
            servesTitleLabel.leadingAnchor.constraint(equalTo: servesIcon.trailingAnchor, constant: 12),
            servesTitleLabel.centerYAnchor.constraint(equalTo: servesContainer.centerYAnchor),
            
            servesChevron.trailingAnchor.constraint(equalTo: servesContainer.trailingAnchor, constant: -16),
            servesChevron.centerYAnchor.constraint(equalTo: servesContainer.centerYAnchor),
            servesChevron.widthAnchor.constraint(equalToConstant: 16),
            servesChevron.heightAnchor.constraint(equalToConstant: 16),
            
            servesValueLabel.trailingAnchor.constraint(equalTo: servesChevron.leadingAnchor, constant: -8),
            servesValueLabel.centerYAnchor.constraint(equalTo: servesContainer.centerYAnchor),
            
            cookTimeContainer.topAnchor.constraint(equalTo: servesContainer.bottomAnchor, constant: 16),
            cookTimeContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cookTimeContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            cookTimeContainer.heightAnchor.constraint(equalToConstant: 60),
            
            cookTimeIcon.leadingAnchor.constraint(equalTo: cookTimeContainer.leadingAnchor, constant: 16),
            cookTimeIcon.centerYAnchor.constraint(equalTo: cookTimeContainer.centerYAnchor),
            cookTimeIcon.widthAnchor.constraint(equalToConstant: 24),
            cookTimeIcon.heightAnchor.constraint(equalToConstant: 24),
            
            cookTimeTitleLabel.leadingAnchor.constraint(equalTo: cookTimeIcon.trailingAnchor, constant: 12),
            cookTimeTitleLabel.centerYAnchor.constraint(equalTo: cookTimeContainer.centerYAnchor),
            
            cookTimeChevron.trailingAnchor.constraint(equalTo: cookTimeContainer.trailingAnchor, constant: -16),
            cookTimeChevron.centerYAnchor.constraint(equalTo: cookTimeContainer.centerYAnchor),
            cookTimeChevron.widthAnchor.constraint(equalToConstant: 16),
            cookTimeChevron.heightAnchor.constraint(equalToConstant: 16),
            
            cookTimeValueLabel.trailingAnchor.constraint(equalTo: cookTimeChevron.leadingAnchor, constant: -8),
            cookTimeValueLabel.centerYAnchor.constraint(equalTo: cookTimeContainer.centerYAnchor)
        ])
    }
    
    private func setupIngredientsSection() {
        ingredientsTitleLabel.text = "Ingredients"
        ingredientsTitleLabel.font = UIFont(name: AppFont.SemiBold, size: 20) ?? .systemFont(ofSize: 20, weight: .semibold)
        ingredientsTitleLabel.textColor = UIColor(red: 0.094, green: 0.094, blue: 0.094, alpha: 1.0) // #181818
        
        ingredientsStackView.axis = .vertical
        ingredientsStackView.spacing = 16
        
        addIngredientButton.setTitle("+ Add new Ingredient", for: .normal)
        addIngredientButton.titleLabel?.font = UIFont(name: AppFont.SemiBold, size: 16) ?? .systemFont(ofSize: 16, weight: .semibold)
        addIngredientButton.setTitleColor(UIColor(red: 0.094, green: 0.094, blue: 0.094, alpha: 1.0), for: .normal)
        addIngredientButton.addTarget(self, action: #selector(addNewIngredientTapped), for: .touchUpInside)
        
        contentView.addSubview(ingredientsTitleLabel)
        contentView.addSubview(ingredientsStackView)
        contentView.addSubview(addIngredientButton)
        
        ingredientsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        ingredientsStackView.translatesAutoresizingMaskIntoConstraints = false
        addIngredientButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            ingredientsTitleLabel.topAnchor.constraint(equalTo: cookTimeContainer.bottomAnchor, constant: 24),
            ingredientsTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            ingredientsTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            ingredientsStackView.topAnchor.constraint(equalTo: ingredientsTitleLabel.bottomAnchor, constant: 16),
            ingredientsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            ingredientsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            addIngredientButton.topAnchor.constraint(equalTo: ingredientsStackView.bottomAnchor, constant: 16),
            addIngredientButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        ])
        
        addDefaultIngredientFields()
    }
    
    private func addDefaultIngredientFields() {
        addIngredientField()
        addIngredientField()
    }
    
    private func addIngredientField(name: String = "", quantity: String = "") {
        let ingredientRow = UIView()
        
        // Ingredient name field
        let nameField = UITextField()
        nameField.placeholder = "Item name"
        nameField.font = UIFont(name: AppFont.Regular, size: 14) ?? .systemFont(ofSize: 14)
        nameField.borderStyle = .none
        nameField.backgroundColor = .clear
        nameField.layer.cornerRadius = 10
        nameField.layer.borderWidth = 1
        nameField.layer.borderColor = UIColor.systemGray4.cgColor
        nameField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        nameField.leftViewMode = .always
        
        // Quantity field
        let quantityField = UITextField()
        quantityField.placeholder = "Quantity"
        quantityField.font = UIFont(name: AppFont.Regular, size: 14) ?? .systemFont(ofSize: 14)
        quantityField.borderStyle = .none
        quantityField.backgroundColor = .clear
        quantityField.layer.cornerRadius = 10
        quantityField.layer.borderWidth = 1
        quantityField.layer.borderColor = UIColor.systemGray4.cgColor
        quantityField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        quantityField.leftViewMode = .always
        
        let actionButton = UIButton(type: .system)
        actionButton.setImage(UIImage.plusIcon, for: .normal)
        actionButton.tintColor = .black
        actionButton.addTarget(self, action: #selector(addIngredientTapped(_:)), for: .touchUpInside)
        
        actionButton.tag = ingredientsStackView.arrangedSubviews.count
        nameField.tag = actionButton.tag * 10 + 1
        quantityField.tag = actionButton.tag * 10 + 2
        
        ingredientRow.addSubview(nameField)
        ingredientRow.addSubview(quantityField)
        ingredientRow.addSubview(actionButton)
        
        nameField.translatesAutoresizingMaskIntoConstraints = false
        quantityField.translatesAutoresizingMaskIntoConstraints = false
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameField.leadingAnchor.constraint(equalTo: ingredientRow.leadingAnchor, constant: 16),
            nameField.centerYAnchor.constraint(equalTo: ingredientRow.centerYAnchor),
            nameField.widthAnchor.constraint(equalToConstant: 164),
            nameField.heightAnchor.constraint(equalToConstant: 44),
            
            quantityField.leadingAnchor.constraint(equalTo: nameField.trailingAnchor, constant: 16),
            quantityField.centerYAnchor.constraint(equalTo: ingredientRow.centerYAnchor),
            quantityField.widthAnchor.constraint(equalToConstant: 115),
            quantityField.heightAnchor.constraint(equalToConstant: 44),
            
            actionButton.leadingAnchor.constraint(equalTo: quantityField.trailingAnchor, constant: 13.5),
            actionButton.centerYAnchor.constraint(equalTo: ingredientRow.centerYAnchor),
            actionButton.widthAnchor.constraint(equalToConstant: 24),
            actionButton.heightAnchor.constraint(equalToConstant: 24),
            
            ingredientRow.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        ingredientsStackView.addArrangedSubview(ingredientRow)
    }
    
    private func setupCreateButton() {
        createButton.setTitle("Create Recipe", for: .normal)
        createButton.titleLabel?.font = UIFont(name: AppFont.SemiBold, size: 16) ?? .systemFont(ofSize: 16, weight: .semibold)
        createButton.backgroundColor = UIColor(red: 0.886, green: 0.243, blue: 0.243, alpha: 1.0) // #E23E3E
        createButton.setTitleColor(.white, for: .normal)
        createButton.layer.cornerRadius = 8
        createButton.addTarget(self, action: #selector(createTapped), for: .touchUpInside)
        
        contentView.addSubview(createButton)
        
        createButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            createButton.topAnchor.constraint(equalTo: addIngredientButton.bottomAnchor, constant: 24),
            createButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            createButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            createButton.heightAnchor.constraint(equalToConstant: 56),
            createButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32)
        ])
    }
    
    // MARK: - Actions
        
    @objc private func backTapped() {
        dismiss(animated: true)
    }
    
    @objc private func imageEditTapped() {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 1
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        present(picker, animated: true)
    }
    
    @objc private func servesTapped() {
        let alert = UIAlertController(title: "Select Servings", message: "Choose number of people", preferredStyle: .actionSheet)
        
        let servings = ["1 person", "2 people", "3 people", "4 people", "5 people", "6 people", "8 people", "10 people"]
        
        for serving in servings {
            alert.addAction(UIAlertAction(title: serving, style: .default) { _ in
                self.servesValueLabel.text = serving
            })
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
    
    @objc private func cookTimeTapped() {
        let alert = UIAlertController(title: "Select Cook Time", message: "Choose cooking duration", preferredStyle: .actionSheet)
        
        let times = ["5 min", "10 min", "15 min", "20 min", "25 min", "30 min", "45 min", "60 min", "90 min", "120 min"]
        
        for time in times {
            alert.addAction(UIAlertAction(title: time, style: .default) { _ in
                self.cookTimeValueLabel.text = time
            })
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
    
    @objc private func addNewIngredientTapped() {
        addIngredientField()
    }
    
    @objc private func addIngredientTapped(_ sender: UIButton) {
        guard let ingredientRow = sender.superview else { return }
        
        let nameField = ingredientRow.subviews.compactMap { $0 as? UITextField }.first { $0.tag == sender.tag * 10 + 1 }
        let quantityField = ingredientRow.subviews.compactMap { $0 as? UITextField }.first { $0.tag == sender.tag * 10 + 2 }
        
        // Checking fields
        let hasName = !(nameField?.text?.isEmpty ?? true)
        let hasQuantity = !(quantityField?.text?.isEmpty ?? true)
        
        if hasName || hasQuantity {
            sender.setImage(UIImage.minusIcon, for: .normal)
            sender.tintColor = .black
            sender.removeTarget(self, action: #selector(addIngredientTapped(_:)), for: .touchUpInside)
            sender.addTarget(self, action: #selector(removeIngredientTapped(_:)), for: .touchUpInside)
            
            nameField?.isEnabled = false
            quantityField?.isEnabled = false
            nameField?.backgroundColor = UIColor.systemGray6
            quantityField?.backgroundColor = UIColor.systemGray6
        } else {
            let alert = UIAlertController(title: "Empty Fields", message: "Please fill in ingredient name and quantity", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
        }
    }
    
    @objc private func removeIngredientTapped(_ sender: UIButton) {
        guard let ingredientRow = sender.superview else { return }
        ingredientRow.removeFromSuperview()
    }
    
    @objc private func createTapped() {
        // Validate title field
        if titleField.text?.isEmpty ?? true {
            titleField.layer.borderColor = UIColor.systemRed.cgColor
            return
        } else {
            titleField.layer.borderColor = UIColor.systemGray4.cgColor
        }
        
        createRecipe()
    }
    
    private func createRecipe() {
        // Collect recipe data
        let title = titleField.text ?? ""
        let servesText = servesValueLabel.text ?? "2 people"
        let serves = Int(servesText.components(separatedBy: .whitespaces).first ?? "2") ?? 2
        
        let cookTimeText = cookTimeValueLabel.text ?? "10 min"
        let cookTime = Int(cookTimeText.components(separatedBy: .whitespaces).first ?? "10") ?? 10
        
        // Collect ingredients
        var ingredients: [CreatedIngredient] = []
        for arrangedSubview in ingredientsStackView.arrangedSubviews {
            let ingredientRow = arrangedSubview
            let textFields = ingredientRow.subviews.compactMap { $0 as? UITextField }
            if textFields.count >= 2 {
                let nameField = textFields[0]
                let quantityField = textFields[1]
                
                if !(nameField.text?.isEmpty ?? true) && !(quantityField.text?.isEmpty ?? true) {
                    let ingredient = CreatedIngredient(
                        name: nameField.text ?? "",
                        quantity: quantityField.text ?? ""
                    )
                    ingredients.append(ingredient)
                }
            }
        }
        
        // Convert image to data
        var imageData: Data? = nil
        if let image = imageView.image {
            imageData = image.jpegData(compressionQuality: 0.8)
        }
        
        // Create recipe
        let recipe = CreatedRecipe(
            title: title,
            serves: serves,
            cookTimeMinutes: cookTime,
            ingredients: ingredients,
            imageData: imageData
        )
        
        // Save recipe
        Task {
            do {
                try await persistenceService.save(recipe: recipe)
                await MainActor.run {
                    self.showSuccessPopup()
                }
        } catch {
                await MainActor.run {
                    let alert = UIAlertController(title: "Error", message: "Failed to save recipe: \(error.localizedDescription)", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alert, animated: true)
                }
            }
        }
    }
    
    private func showSuccessPopup() {
        let alert = UIAlertController(
            title: "Recipe Created Successfully!",
            message: "Your recipe has been saved to your collection.",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "View My Recipes", style: .default) { _ in
            self.navigateToProfile()
        })
        
        alert.addAction(UIAlertAction(title: "Create Another", style: .cancel) { _ in
            self.clearForm()
        })
        
        present(alert, animated: true)
    }
    
    private func clearForm() {
        // Clear all fields
        titleField.text = ""
        imageView.image = nil
        imageEditButton.isHidden = false
        
        // Clear all ingredient fields
        for arrangedSubview in ingredientsStackView.arrangedSubviews {
            arrangedSubview.removeFromSuperview()
        }
        
        // Add default empty fields
        addDefaultIngredientFields()
    }
    
    private func navigateToProfile() {
        // Navigate to Profile tab using notification or delegate pattern
        NotificationCenter.default.post(name: NSNotification.Name("NavigateToProfile"), object: nil)
        dismiss(animated: true)
    }
}

extension CreateRecipeViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        guard let result = results.first else { return }
        
        if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
            result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] object, _ in
                guard let self = self, let image = object as? UIImage else { return }
                
                DispatchQueue.main.async {
                    self.imageView.image = image
                    self.imageEditButton.isHidden = true
                }
            }
        }
    }
}
