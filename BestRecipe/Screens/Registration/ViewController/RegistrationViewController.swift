//
//  RegistrationViewController.swift
//  BestRecipe
//
//  Created by Zarina Sadykova on 31.08.25.
//
import UIKit
import SnapKit

class RegistrationViewController: UIViewController {
    
    // MARK: - UI Elements
    private let spoonsImageView = UIImageView()
    private let fullTextLabel = UILabel()
    private var textFields: [TextInputView] = []
    
    private let signUpButton = CustomButton(title: "Sign Up", cornerRadius: 10)
    private let alreadyHaveAccountLabel = UILabel()
    
    // Конфигурация полей
    private let fieldConfigs: [RegistrationFieldConfig] = [
        RegistrationFieldConfig(title: "First Name",
                                placeholder: "Enter your first name",
                                isSecure: false,
                                keyboardType: .default),
        RegistrationFieldConfig(title: "Last Name",
                                placeholder: "Enter your last name",
                                isSecure: false,
                                keyboardType: .default),
        RegistrationFieldConfig(title: "E-mail",
                                placeholder: "Enter your email",
                                isSecure: false,
                                keyboardType: .emailAddress),
        RegistrationFieldConfig(title: "Password",
                                placeholder: "Create password",
                                isSecure: true,
                                keyboardType: .default),
        RegistrationFieldConfig(title: "Confirm Password",
                                placeholder: "Confirm your password",
                                isSecure: true,
                                keyboardType: .default)
    ]
    
    // Autofill полей для теста
    private func autofillMockUser() {
        guard textFields.count == fieldConfigs.count else { return }
        textFields[0].text = MockUser.firstName
        textFields[1].text = MockUser.lastName
        textFields[2].text = MockUser.email
        textFields[3].text = MockUser.password
        textFields[4].text = MockUser.password // confirm
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupLoginTapGesture()
        autofillMockUser()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = .white
        
        // Картинка
        spoonsImageView.image = UIImage(named: "Spoons")
        spoonsImageView.contentMode = .scaleAspectFit
        view.addSubview(spoonsImageView)
        
        // Текст
        fullTextLabel.text = "Create your account\nexplore best recipes"
        fullTextLabel.textColor = .white
        fullTextLabel.font = UIFont(name: AppFont.Bold, size: 28)
        fullTextLabel.numberOfLines = 2
        spoonsImageView.addSubview(fullTextLabel)
        
        // Поля по конфигу
        for config in fieldConfigs {
            let textField = TextInputView()
            textField.title = config.title
            textField.placeholder = config.placeholder
            textField.cornerRadius = 20
            textField.isSecureTextEntry = config.isSecure
            textField.setKeyboardType(config.keyboardType)
            textField.hasOutline = true
            textField.outlineColor = .systemGray4
            textField.backgroundColorType = .systemGray6
            view.addSubview(textField)
            textFields.append(textField)
        }
        
        // Кнопка
        signUpButton.backgroundColor = .primary50
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        view.addSubview(signUpButton)
        
        setupAlreadyHaveAccountText()
    }
    
    private func setupAlreadyHaveAccountText() {
        let fullText = "Already have an account? Login"
        let attributedString = NSMutableAttributedString(string: fullText)
        
        if let loginRange = fullText.range(of: "Login") {
            let nsRange = NSRange(loginRange, in: fullText)
            attributedString.addAttribute(.foregroundColor, value: UIColor.success100, range: nsRange)
            attributedString.addAttribute(.font, value: UIFont(name: AppFont.Regular, size: 14)!, range: nsRange)
        }
        
        attributedString.addAttribute(.font, value: UIFont(name: AppFont.Regular, size: 14)!, range: NSRange(location: 0, length: fullText.count))
        attributedString.addAttribute(.foregroundColor, value: UIColor.gray, range: NSRange(location: 0, length: fullText.count - 5))
        
        alreadyHaveAccountLabel.attributedText = attributedString
        alreadyHaveAccountLabel.textAlignment = .center
        alreadyHaveAccountLabel.isUserInteractionEnabled = true
        view.addSubview(alreadyHaveAccountLabel)
    }
    
    private func setupLoginTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(loginTapped))
        alreadyHaveAccountLabel.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Constraints
    private func setupConstraints() {
        spoonsImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(-20)
            make.width.equalTo(482)
            make.height.equalTo(187)
        }
        
        fullTextLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(80)
            make.centerY.equalToSuperview().offset(50)
        }
        
        // Поля
        var previous: UIView = spoonsImageView
        for (index, textField) in textFields.enumerated() {
            textField.snp.makeConstraints { make in
                make.top.equalTo(previous.snp.bottom).offset(index == 0 ? 80 : 40)
                make.centerX.equalToSuperview()
                make.width.equalTo(335)
                make.height.equalTo(45)
            }
            previous = textField
        }
        
        // Кнопка
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(previous.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.width.equalTo(335)
            make.height.equalTo(56)
        }
        
        alreadyHaveAccountLabel.snp.makeConstraints { make in
            make.top.equalTo(signUpButton.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
    }
    
    private func resetFieldBorders() {
        textFields.forEach { $0.outlineColor = .systemGray4 }
    }
    
    private func highlightErrorField(at index: Int) {
        guard index < textFields.count else { return }
        textFields[index].outlineColor = .red
    }
    
    // MARK: - Actions
    @objc private func signUpButtonTapped() {
        let values = textFields.map { $0.text ?? "" }
        let titles = fieldConfigs.map { $0.title }

        if let error = RegistrationValidator.validate(fields: values, fieldTitles: titles) {
            showAlert(message: error.localizedDescription)
            return
        }
        
        // Показываем успешное сообщение и переходим на логин
        showSuccessAlertAndGoToLogin()
    }
    
    private func showSuccessAlertAndGoToLogin() {
        let alert = UIAlertController(
            title: "Success!",
            message: "Account created successfully!\nPlease log in with your credentials.",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            // Закрываем текущий экран регистрации и возвращаемся на логин
            self?.dismiss(animated: true)
        })
        
        present(alert, animated: true)
    }
    
    @objc private func loginTapped() {
        dismiss(animated: true)
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
