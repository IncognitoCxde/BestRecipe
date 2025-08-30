import UIKit
import PhotosUI

final class CreateRecipeViewController: UIViewController {
    
    private let viewModel: CreateRecipeViewModel
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let imageView = UIImageView()
    private let imageEditButton = UIButton(type: .system)
    
    private let titleField = UITextField()
    
    private let servesRow = UIControl()
    private let servesIcon = UIImageView(image: UIImage(systemName: "person.2"))
    private let servesTitleLabel = UILabel()
    private let servesValueLabel = UILabel()
    private let servesChevron = UIImageView(image: UIImage(systemName: "chevron.right"))
    
    private let cookTimeRow = UIControl()
    private let cookTimeIcon = UIImageView(image: UIImage(systemName: "clock"))
    private let cookTimeTitleLabel = UILabel()
    private let cookTimeValueLabel = UILabel()
    private let cookTimeChevron = UIImageView(image: UIImage(systemName: "chevron.right"))
    
    private let ingredientsHeaderLabel = UILabel()
    private let ingredientsTableView = UITableView(frame: .zero, style: .insetGrouped)
    private var tableHeightConstraint: NSLayoutConstraint?
    
    private let createButton = UIButton(type: .system)
    private let loadingIndicator = UIActivityIndicatorView(style: .medium)
    
    init(viewModel: CreateRecipeViewModel = CreateRecipeViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupTableView()
        updateUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Create recipe"
        
        setupNavigationBar()
        setupImageSection()
        setupTitleField()
        setupMetaRows()
        setupIngredientsSection()
        setupCreateButton()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "ellipsis"),
            style: .plain,
            target: self,
            action: #selector(moreOptionsTapped)
        )
    }
    
    private func setupImageSection() {
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .secondarySystemBackground
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        
        imageEditButton.setImage(UIImage(systemName: "pencil"), for: .normal)
        imageEditButton.tintColor = .label
        imageEditButton.backgroundColor = .systemBackground
        imageEditButton.layer.cornerRadius = 20
        imageEditButton.layer.shadowColor = UIColor.black.cgColor
        imageEditButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        imageEditButton.layer.shadowRadius = 4
        imageEditButton.layer.shadowOpacity = 0.1
        imageEditButton.addTarget(self, action: #selector(imageEditTapped), for: .touchUpInside)
    }
    
    private func setupTitleField() {
        titleField.placeholder = "Recipe title"
        titleField.font = .systemFont(ofSize: 16, weight: .medium)
        titleField.backgroundColor = .systemBackground
        titleField.layer.cornerRadius = 10
        titleField.layer.borderWidth = 1
        titleField.layer.borderColor = UIColor.systemGray4.cgColor
        titleField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 44))
        titleField.leftViewMode = .always
        titleField.addTarget(self, action: #selector(titleChanged), for: .editingChanged)
    }
    
    private func setupMetaRows() {
        setupRow(servesRow, icon: servesIcon, title: servesTitleLabel, value: servesValueLabel, chevron: servesChevron, titleText: "Serves", action: #selector(servesTapped))
        setupRow(cookTimeRow, icon: cookTimeIcon, title: cookTimeTitleLabel, value: cookTimeValueLabel, chevron: cookTimeChevron, titleText: "Cook time", action: #selector(cookTimeTapped))
    }
    
    private func setupRow(_ row: UIControl, icon: UIImageView, title: UILabel, value: UILabel, chevron: UIImageView, titleText: String, action: Selector) {
        row.backgroundColor = .systemGray6
        row.layer.cornerRadius = 10
        row.addTarget(self, action: action, for: .touchUpInside)
        
        icon.tintColor = .label
        
        title.text = titleText
        title.font = .systemFont(ofSize: 16, weight: .semibold)
        title.textColor = .label
        
        value.font = .systemFont(ofSize: 16, weight: .semibold)
        value.textColor = .secondaryLabel
        value.textAlignment = .right
        value.setContentHuggingPriority(.required, for: .horizontal)
        
        chevron.tintColor = .tertiaryLabel
    }
    
    private func setupIngredientsSection() {
        ingredientsHeaderLabel.text = "Ingredients"
        ingredientsHeaderLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        ingredientsHeaderLabel.textColor = .label
    }
    
    private func setupTableView() {
        ingredientsTableView.dataSource = self
        ingredientsTableView.delegate = self
        ingredientsTableView.register(IngredientCell.self, forCellReuseIdentifier: "IngredientCell")
        ingredientsTableView.register(AddIngredientCell.self, forCellReuseIdentifier: "AddIngredientCell")
        ingredientsTableView.register(AddNewIngredientCell.self, forCellReuseIdentifier: "AddNewIngredientCell")
        ingredientsTableView.isScrollEnabled = false
        ingredientsTableView.backgroundColor = .clear
        ingredientsTableView.separatorStyle = .none
    }
    
    private func setupCreateButton() {
        createButton.setTitle("Create recipe", for: .normal)
        createButton.backgroundColor = .systemRed
        createButton.setTitleColor(.white, for: .normal)
        createButton.titleLabel?.font = UIFont(name: AppFont.SemiBold, size: 16) ?? .systemFont(ofSize: 16, weight: .semibold)
        createButton.layer.cornerRadius = 8
        createButton.addTarget(self, action: #selector(createRecipeTapped), for: .touchUpInside)
        
        loadingIndicator.color = .white
    }
    
    private func setupConstraints() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        let components = [imageView, imageEditButton, titleField, servesRow, servesIcon, servesTitleLabel, servesValueLabel, servesChevron, cookTimeRow, cookTimeIcon, cookTimeTitleLabel, cookTimeValueLabel, cookTimeChevron, ingredientsHeaderLabel, ingredientsTableView, createButton, loadingIndicator]
        
        components.forEach { component in
            component.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(component)
        }
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            imageEditButton.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 12),
            imageEditButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -12),
            imageEditButton.widthAnchor.constraint(equalToConstant: 40),
            imageEditButton.heightAnchor.constraint(equalToConstant: 40),
            
            titleField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            titleField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            titleField.heightAnchor.constraint(equalToConstant: 44),
            
            servesRow.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: 16),
            servesRow.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            servesRow.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            servesRow.heightAnchor.constraint(equalToConstant: 56),
            
            servesIcon.leadingAnchor.constraint(equalTo: servesRow.leadingAnchor, constant: 12),
            servesIcon.centerYAnchor.constraint(equalTo: servesRow.centerYAnchor),
            servesIcon.widthAnchor.constraint(equalToConstant: 24),
            servesIcon.heightAnchor.constraint(equalToConstant: 24),
            
            servesTitleLabel.leadingAnchor.constraint(equalTo: servesIcon.trailingAnchor, constant: 12),
            servesTitleLabel.centerYAnchor.constraint(equalTo: servesRow.centerYAnchor),
            
            servesValueLabel.trailingAnchor.constraint(equalTo: servesChevron.leadingAnchor, constant: -8),
            servesValueLabel.centerYAnchor.constraint(equalTo: servesRow.centerYAnchor),
            
            servesChevron.trailingAnchor.constraint(equalTo: servesRow.trailingAnchor, constant: -12),
            servesChevron.centerYAnchor.constraint(equalTo: servesRow.centerYAnchor),
            
            cookTimeRow.topAnchor.constraint(equalTo: servesRow.bottomAnchor, constant: 12),
            cookTimeRow.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cookTimeRow.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            cookTimeRow.heightAnchor.constraint(equalToConstant: 56),
            
            cookTimeIcon.leadingAnchor.constraint(equalTo: cookTimeRow.leadingAnchor, constant: 12),
            cookTimeIcon.centerYAnchor.constraint(equalTo: cookTimeRow.centerYAnchor),
            cookTimeIcon.widthAnchor.constraint(equalToConstant: 24),
            cookTimeIcon.heightAnchor.constraint(equalToConstant: 24),
            
            cookTimeTitleLabel.leadingAnchor.constraint(equalTo: cookTimeIcon.trailingAnchor, constant: 12),
            cookTimeTitleLabel.centerYAnchor.constraint(equalTo: cookTimeRow.centerYAnchor),
            
            cookTimeValueLabel.trailingAnchor.constraint(equalTo: cookTimeChevron.leadingAnchor, constant: -8),
            cookTimeValueLabel.centerYAnchor.constraint(equalTo: cookTimeRow.centerYAnchor),
            
            cookTimeChevron.trailingAnchor.constraint(equalTo: cookTimeRow.trailingAnchor, constant: -12),
            cookTimeChevron.centerYAnchor.constraint(equalTo: cookTimeRow.centerYAnchor),
            
            ingredientsHeaderLabel.topAnchor.constraint(equalTo: cookTimeRow.bottomAnchor, constant: 16),
            ingredientsHeaderLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            ingredientsTableView.topAnchor.constraint(equalTo: ingredientsHeaderLabel.bottomAnchor, constant: 8),
            ingredientsTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            ingredientsTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            createButton.topAnchor.constraint(equalTo: ingredientsTableView.bottomAnchor, constant: 16),
            createButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            createButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            createButton.heightAnchor.constraint(equalToConstant: 56),
            createButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
            
            loadingIndicator.centerXAnchor.constraint(equalTo: createButton.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: createButton.centerYAnchor)
        ])
        
        tableHeightConstraint = ingredientsTableView.heightAnchor.constraint(equalToConstant: 60)
        tableHeightConstraint?.isActive = true
    }
    
    @objc private func moreOptionsTapped() {
        
    }
    
    @objc private func imageEditTapped() {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 1
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        present(picker, animated: true)
    }
    
    @objc private func titleChanged() {
        viewModel.updateTitle(titleField.text ?? "")
        updateCreateButtonState()
    }
    
    @objc private func servesTapped() {
        let alert = UIAlertController(title: "Serves", message: nil, preferredStyle: .actionSheet)
        
        [1, 2, 3, 4, 5, 6, 8, 10, 12].forEach { servings in
            alert.addAction(UIAlertAction(title: "\(servings)", style: .default) { [weak self] _ in
                self?.viewModel.updateServes(servings)
                self?.updateMetaLabels()
            })
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
    
    @objc private func cookTimeTapped() {
        let alert = UIAlertController(title: "Cook time (minutes)", message: nil, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.keyboardType = .numberPad
            textField.placeholder = "e.g. 20"
            textField.text = "\(self.viewModel.inputs.cookTimeMinutes)"
        }
        
        alert.addAction(UIAlertAction(title: "Set", style: .default) { [weak self] _ in
            guard let text = alert.textFields?.first?.text,
                  let minutes = Int(text) else { return }
            self?.viewModel.updateCookTime(minutes)
            self?.updateMetaLabels()
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
    
    @objc private func createRecipeTapped() {
        Task {
            await createRecipe()
        }
    }
    
    private func updateUI() {
        updateMetaLabels()
        updateCreateButtonState()
        updateTableHeight()
    }
    
    private func updateMetaLabels() {
        servesValueLabel.text = String(format: "%02d", viewModel.inputs.serves)
        cookTimeValueLabel.text = "\(viewModel.inputs.cookTimeMinutes) min"
    }
    
    private func updateCreateButtonState() {
        let validation = viewModel.validate()
        createButton.alpha = validation.isValid ? 1.0 : 0.5
        createButton.isEnabled = validation.isValid
        
        let isEmpty = titleField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true
        titleField.layer.borderColor = isEmpty ? UIColor.systemRed.cgColor : UIColor.systemGray4.cgColor
    }
    
    private func updateTableHeight() {
        ingredientsTableView.layoutIfNeeded()
        let contentHeight = ingredientsTableView.contentSize.height
        tableHeightConstraint?.constant = max(60, contentHeight)
        view.layoutIfNeeded()
    }
    
    private func setLoading(_ loading: Bool) {
        createButton.setTitle(loading ? "" : "Create recipe", for: .normal)
        createButton.isEnabled = !loading
        
        if loading {
            loadingIndicator.startAnimating()
        } else {
            loadingIndicator.stopAnimating()
        }
    }
    
    @MainActor
    private func createRecipe() async {
        setLoading(true)
        
        do {
            _ = try await viewModel.createRecipe()
            setLoading(false)
            showSuccessPopup()
        } catch {
            setLoading(false)
            showError(error.localizedDescription)
        }
    }
    
    private func showSuccessPopup() {
        let popup = SuccessPopupView()
        popup.onViewRecipesTapped = { [weak self] in
            popup.hide()
            self?.navigateToProfile()
        }
        popup.show(in: view)
    }
    
    private func navigateToProfile() {
        // Navigate to profile tab
        if let tabBarController = tabBarController {
            tabBarController.selectedIndex = 2 // Profile tab index
        }
    }
    
    private func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
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
                    self.viewModel.updateImage(image.jpegData(compressionQuality: 0.8))
                }
            }
        }
    }
}

extension CreateRecipeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let ingredientsCount = viewModel.inputs.ingredients.count
        let addNewRowCount = viewModel.inputs.isAddingNewIngredient ? 1 : 0
        let addButtonRowCount = 1
        return ingredientsCount + addNewRowCount + addButtonRowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ingredientsCount = viewModel.inputs.ingredients.count
        
        if indexPath.row < ingredientsCount {
            // Existing ingredient
            let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath) as! IngredientCell
            let ingredient = viewModel.inputs.ingredients[indexPath.row]
            cell.configure(with: ingredient)
            cell.onDelete = { [weak self] in
                self?.viewModel.removeIngredient(id: ingredient.id)
                self?.ingredientsTableView.reloadData()
                self?.updateTableHeight()
            }
            return cell
        } else if indexPath.row == ingredientsCount && viewModel.inputs.isAddingNewIngredient {
            // Add new ingredient input
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddIngredientCell", for: indexPath) as! AddIngredientCell
            cell.onAddIngredient = { [weak self] name, quantity in
                self?.viewModel.addIngredient(name: name, quantity: quantity)
                self?.viewModel.cancelAddingNewIngredient()
                self?.ingredientsTableView.reloadData()
                self?.updateTableHeight()
            }
            return cell
        } else {
            // Add new ingredient button
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddNewIngredientCell", for: indexPath) as! AddNewIngredientCell
            cell.onAddNewTapped = { [weak self] in
                self?.viewModel.toggleAddingNewIngredient()
                self?.ingredientsTableView.reloadData()
                self?.updateTableHeight()
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
