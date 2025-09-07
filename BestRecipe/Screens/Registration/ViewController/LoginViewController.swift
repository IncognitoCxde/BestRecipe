//
//  RegistrationViewController.swift
//  BestRecipe
//
//  Created by Zarina Sadykova on 31.08.25.
//
import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
    // MARK: - UI Elements
    private let logoSquareView = SquareView.createWithLogo()
    private let loginTextField = TextInputView()
    private let passwordTextField = TextInputView()
    private let loginButton = CustomButton(title: "Log In", cornerRadius: 10)
    private let orContinueLabel = UILabel()
    private let googleButton = GoogleButton()
    private let signInLabel = UILabel() // Добавляем текст с ссылкой
    
    
    private func autofillMockLogin() {
        loginTextField.text = MockUser.email
        passwordTextField.text = MockUser.password
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupSignInTapGesture()
        autofillMockLogin()
    }
    
    // MARK: - Setup
    private func setupUI() {
        view.backgroundColor = .white
        
        // Настройка логотипа
        logoSquareView.setBackgroundColor(.clear)
        logoSquareView.setCornerRadius(0)
        view.addSubview(logoSquareView)
        
        // Настройка поля логина
        loginTextField.title = "Enter your Login"
        loginTextField.placeholder = "Login"
        loginTextField.setKeyboardType(.emailAddress)
        loginTextField.hasOutline = true
        loginTextField.outlineColor = .systemGray4
        loginTextField.backgroundColorType = .systemGray6
        view.addSubview(loginTextField)
        
        // Настройка поля пароля
        passwordTextField.title = "Enter your Password"
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.hasOutline = true
        passwordTextField.outlineColor = .systemGray4
        passwordTextField.backgroundColorType = .systemGray6
        view.addSubview(passwordTextField)
        
        // Настройка кнопки
        loginButton.backgroundColor = .primary50
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        view.addSubview(loginButton)
        
        // Настройка текста "Or"
        orContinueLabel.text = "───────  or  ───────"
        orContinueLabel.textColor = .gray
        orContinueLabel.font = UIFont.systemFont(ofSize: 16)
        orContinueLabel.textAlignment = .center
        view.addSubview(orContinueLabel)
        
        // Настройка Google кнопки
        googleButton.addTarget(self, action: #selector(googleButtonTapped), for: .touchUpInside)
        view.addSubview(googleButton)
        
        // Настройка текста с ссылкой
        setupSignInText()
    }
    
    private func setupSignInText() {
        let fullText = "Need to create an account? Sign Up"
        let attributedString = NSMutableAttributedString(string: fullText)
        
        // Находим диапазон текста "Sign In"
        if let signInRange = fullText.range(of: "Sign Up") {
            let nsRange = NSRange(signInRange, in: fullText)

            attributedString.addAttribute(.foregroundColor, value: UIColor.success100, range: nsRange)
            attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 18, weight: .bold), range: nsRange)
        }
        
        // Устанавливаем обычный стиль для остального текста
        attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 14), range: NSRange(location: 0, length: fullText.count))
        attributedString.addAttribute(.foregroundColor, value: UIColor.gray, range: NSRange(location: 0, length: fullText.count - 7))
        
        signInLabel.attributedText = attributedString
        signInLabel.textAlignment = .center
        signInLabel.isUserInteractionEnabled = true
        view.addSubview(signInLabel)
    }
    
    private func setupSignInTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(signInTapped))
        signInLabel.addGestureRecognizer(tapGesture)
    }
    
    private func setupConstraints() {
        // Логотип
        logoSquareView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(30)
        }
        
        // Поле логина
        loginTextField.snp.makeConstraints { make in
            make.top.equalTo(logoSquareView.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(335)
            make.height.equalTo(45)
        }
        
        // Поле пароля
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(loginTextField.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.width.equalTo(335)
            make.height.equalTo(45)
        }
        
        // Кнопка Log in
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(335)
            make.height.equalTo(56)
        }
        
        // Текст "Or continue with"
        orContinueLabel.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.width.equalTo(335)
        }
        
        // Google кнопка под текстом "or"
        googleButton.snp.makeConstraints { make in
            make.top.equalTo(orContinueLabel.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.width.equalTo(335)
            make.height.equalTo(56)
        }
        
        // Текст с ссылкой под Google кнопкой
        signInLabel.snp.makeConstraints { make in
            make.top.equalTo(googleButton.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
    }
                                         
    // MARK: - Actions
    @objc private func loginButtonTapped() {
        guard let login = loginTextField.text, !login.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showAlert(message: "Please fill in all fields")
            return
        }
        
        if login == MockUser.email && password == MockUser.password {
            print("✅ Successful login: \(login)")
            let tabBarController = CustomTabBarController()
            tabBarController.modalPresentationStyle = .fullScreen
            present(tabBarController, animated: true)
        } else if login != MockUser.email {
            showAlert(message: "❌ Invalid email")
        } else {
            showAlert(message: "❌ Invalid password")
        }
    }
    
    @objc private func googleButtonTapped() {
        print("Google button tapped")
        // Обработка входа через Google
    }
    
    @objc private func signInTapped() {
        print("Sign Up tapped")
        // Переход на экран ввода данных (регистрации)
        let registrationVC = RegistrationViewController()
        registrationVC.modalPresentationStyle = .fullScreen
        present(registrationVC, animated: true)
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
