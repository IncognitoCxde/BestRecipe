import UIKit

final class IngredientCell: UITableViewCell {
    
    var onDelete: (() -> Void)?
    
    private let nameTextField = UITextField()
    private let quantityTextField = UITextField()
    private let deleteButton = UIButton(type: .system)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) { nil }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Устанавливаем радиус и рамки после того, как Auto Layout применил размеры
        nameTextField.layer.masksToBounds = true
        quantityTextField.layer.masksToBounds = true
        deleteButton.layer.masksToBounds = true
        
        // Радиус 10px как в спецификации
        nameTextField.layer.cornerRadius = 10
        quantityTextField.layer.cornerRadius = 10
        deleteButton.layer.cornerRadius = deleteButton.bounds.height / 2  // круглые кнопки
        
        // Рамки
        nameTextField.layer.borderWidth = 1
        nameTextField.layer.borderColor = UIColor.systemGray4.cgColor
        quantityTextField.layer.borderWidth = 1
        quantityTextField.layer.borderColor = UIColor.systemGray4.cgColor
        deleteButton.layer.borderWidth = 1
        deleteButton.layer.borderColor = UIColor.systemGray4.cgColor
        
        // Плавное скругление (iOS 13+)
        if #available(iOS 13.0, *) {
            nameTextField.layer.cornerCurve = .continuous
            quantityTextField.layer.cornerCurve = .continuous
            deleteButton.layer.cornerCurve = .continuous
        }

    }
    
    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none
        
        // Name field - same style as recipe title field but regular font
        nameTextField.borderStyle = .none
        nameTextField.font = UIFont(name: AppFont.regular, size: 16) ?? .systemFont(ofSize: 16, weight: .regular)
        nameTextField.textColor = .label
        nameTextField.backgroundColor = .systemBackground
        nameTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 44))
        nameTextField.leftViewMode = .always
        nameTextField.isUserInteractionEnabled = false
        
        // Quantity field - same style as recipe title field but regular font
        quantityTextField.borderStyle = .none
        quantityTextField.font = UIFont(name: AppFont.regular, size: 16) ?? .systemFont(ofSize: 16, weight: .regular)
        quantityTextField.textColor = .label
        quantityTextField.backgroundColor = .systemBackground
        quantityTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 44))
        quantityTextField.leftViewMode = .always
        quantityTextField.isUserInteractionEnabled = false
        
        // Delete button - minus in transparent rectangle with border
        deleteButton.setImage(IconHelper.getIcon(UIImage.minusIcon, fallback: UIImage.minusIconFallback), for: .normal)
        deleteButton.tintColor = .label
        deleteButton.backgroundColor = .clear
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        [nameTextField, quantityTextField, deleteButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            // Name field - занимает половину доступной ширины минус отступы
            nameTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            nameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameTextField.heightAnchor.constraint(equalToConstant: 44),
            
            // Quantity field - занимает вторую половину доступной ширины
            quantityTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            quantityTextField.leadingAnchor.constraint(equalTo: nameTextField.trailingAnchor, constant: 12),
            quantityTextField.heightAnchor.constraint(equalToConstant: 44),
            
            // Delete button - фиксированная ширина справа
            deleteButton.centerYAnchor.constraint(equalTo: nameTextField.centerYAnchor),
            deleteButton.leadingAnchor.constraint(equalTo: quantityTextField.trailingAnchor, constant: 12),
            deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            deleteButton.widthAnchor.constraint(equalToConstant: 21),
            deleteButton.heightAnchor.constraint(equalToConstant: 21),
            
            // Делаем поля одинаковой ширины - каждое занимает 50% доступного пространства
            nameTextField.widthAnchor.constraint(equalTo: quantityTextField.widthAnchor, multiplier: 1.0),
            
            // Устанавливаем высоту contentView
            contentView.bottomAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 8)
        ])
    }
    
    func configure(with ingredient: CreatedIngredient) {
        nameTextField.text = ingredient.name
        quantityTextField.text = ingredient.quantity
    }
    
    @objc private func deleteButtonTapped() {
        onDelete?()
    }
}

final class AddIngredientCell: UITableViewCell {
    
    var onAddIngredient: ((String, String) -> Void)?
    
    private let nameTextField = UITextField()
    private let quantityTextField = UITextField()
    private let addButton = UIButton(type: .system)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) { nil }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Устанавливаем радиус и рамки после того, как Auto Layout применил размеры
        nameTextField.layer.masksToBounds = true
        quantityTextField.layer.masksToBounds = true
        addButton.layer.masksToBounds = true
        
        // Радиус 10px как в спецификации
        nameTextField.layer.cornerRadius = 10
        quantityTextField.layer.cornerRadius = 10
        addButton.layer.cornerRadius = addButton.bounds.height / 2  // круглые кнопки
        
        // Рамки (устанавливаем по умолчанию, валидация может изменить цвет)
        nameTextField.layer.borderWidth = 1
        if nameTextField.layer.borderColor == UIColor.systemRed.cgColor {
            // Сохраняем красный цвет если была ошибка валидации
            nameTextField.layer.borderColor = UIColor.systemRed.cgColor
        } else {
            nameTextField.layer.borderColor = UIColor.systemGray4.cgColor
        }
        
        quantityTextField.layer.borderWidth = 1
        if quantityTextField.layer.borderColor == UIColor.systemRed.cgColor {
            // Сохраняем красный цвет если была ошибка валидации
            quantityTextField.layer.borderColor = UIColor.systemRed.cgColor
        } else {
            quantityTextField.layer.borderColor = UIColor.systemGray4.cgColor
        }
        
        addButton.layer.borderWidth = 1
        addButton.layer.borderColor = UIColor.systemGray4.cgColor
        
        // Плавное скругление (iOS 13+)
        if #available(iOS 13.0, *) {
            nameTextField.layer.cornerCurve = .continuous
            quantityTextField.layer.cornerCurve = .continuous
            addButton.layer.cornerCurve = .continuous
        }

    }
    
    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none
        
        // Name field - regular font with gray placeholder
        nameTextField.borderStyle = .none
        nameTextField.placeholder = "Ingredient name"
        nameTextField.font = UIFont(name: AppFont.regular, size: 16) ?? .systemFont(ofSize: 16, weight: .regular)
        nameTextField.textColor = .label
        nameTextField.attributedPlaceholder = NSAttributedString(
            string: "Ingredient name",
            attributes: [.foregroundColor: UIColor.systemGray]
        )
        nameTextField.backgroundColor = .systemBackground
        nameTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 44))
        nameTextField.leftViewMode = .always
        
        // Quantity field - regular font with gray placeholder
        quantityTextField.borderStyle = .none
        quantityTextField.placeholder = "Quantity"
        quantityTextField.font = UIFont(name: AppFont.regular, size: 16) ?? .systemFont(ofSize: 16, weight: .regular)
        quantityTextField.textColor = .label
        quantityTextField.attributedPlaceholder = NSAttributedString(
            string: "Quantity",
            attributes: [.foregroundColor: UIColor.systemGray]
        )
        quantityTextField.backgroundColor = .systemBackground
        quantityTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 44))
        quantityTextField.leftViewMode = .always
        
        // Добавляем обработчики изменения текста для сброса красного контура
        nameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        quantityTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        // Add button - black plus in transparent rectangle with border
        addButton.setImage(IconHelper.getIcon(UIImage.plusIcon, fallback: UIImage.plusIconFallback), for: .normal)
        addButton.tintColor = .label
        addButton.backgroundColor = .clear
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        [nameTextField, quantityTextField, addButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            // Name field - занимает всю доступную ширину минус кнопка
            nameTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            nameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameTextField.heightAnchor.constraint(equalToConstant: 44),
            
            // Quantity field - занимает оставшуюся часть
            quantityTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            quantityTextField.leadingAnchor.constraint(equalTo: nameTextField.trailingAnchor, constant: 12),
            quantityTextField.heightAnchor.constraint(equalToConstant: 44),
            
            // Add button - фиксированная ширина справа
            addButton.centerYAnchor.constraint(equalTo: nameTextField.centerYAnchor),
            addButton.leadingAnchor.constraint(equalTo: quantityTextField.trailingAnchor, constant: 12),
            addButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            addButton.widthAnchor.constraint(equalToConstant: 21),
            addButton.heightAnchor.constraint(equalToConstant: 21),
            
            // Делаем поля одинаковой ширины - каждое занимает 50% доступного пространства
            nameTextField.widthAnchor.constraint(equalTo: quantityTextField.widthAnchor, multiplier: 1.0),
            
            // Устанавливаем высоту contentView
            contentView.bottomAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 8)
        ])
    }
    
    @objc private func addButtonTapped() {
        let name = nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let quantity = quantityTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        // Валидация с красными контурами
        let isNameEmpty = name.isEmpty
        let isQuantityEmpty = quantity.isEmpty
        
        nameTextField.layer.borderColor = isNameEmpty ? UIColor.systemRed.cgColor : UIColor.systemGray4.cgColor
        quantityTextField.layer.borderColor = isQuantityEmpty ? UIColor.systemRed.cgColor : UIColor.systemGray4.cgColor
        
        guard !isNameEmpty && !isQuantityEmpty else { return }
        
        onAddIngredient?(name, quantity)
        
        nameTextField.text = ""
        quantityTextField.text = ""
        
        // Сбрасываем цвета контуров после успешного добавления
        nameTextField.layer.borderColor = UIColor.systemGray4.cgColor
        quantityTextField.layer.borderColor = UIColor.systemGray4.cgColor
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        // Сбрасываем красный контур при вводе текста
        textField.layer.borderColor = UIColor.systemGray4.cgColor
    }
}

final class AddNewIngredientCell: UITableViewCell {
    
    var onAddNewTapped: (() -> Void)?
    
    private let addLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) { nil }
    
    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none
        
        addLabel.text = "+ Add new Ingredient"
        addLabel.font = UIFont(name: AppFont.semiBold, size: 16) ?? .systemFont(ofSize: 16, weight: .semibold)
        addLabel.textColor = .black
        addLabel.textAlignment = .left
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(addNewTapped))
        addLabel.addGestureRecognizer(tapGesture)
        addLabel.isUserInteractionEnabled = true
    }
    
    private func setupConstraints() {
        addLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(addLabel)
        
        NSLayoutConstraint.activate([
            addLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            addLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            addLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            addLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    @objc private func addNewTapped() {
        onAddNewTapped?()
    }
}
