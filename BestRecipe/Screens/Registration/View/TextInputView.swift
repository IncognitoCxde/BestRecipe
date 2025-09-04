//
//  TextInputView.swift
//  BestRecipe
//
//  Created by Zarina Sadykova on 31.08.25.
//

import UIKit
import SnapKit

class TextInputView: UIView {
    
    // MARK: - Public Properties
    var text: String? {
        get { textField.text }
        set { textField.text = newValue }
    }
    
    var placeholder: String? {
        didSet {
            textField.placeholder = placeholder
        }
    }
    
    var title: String? {
        didSet {
            titleLabel.text = title
            titleLabel.isHidden = title == nil
        }
    }
    
    var height: CGFloat = 56 {
        didSet {
            containerView.snp.updateConstraints { make in
                make.height.equalTo(height)
            }
        }
    }
    
    var cornerRadius: CGFloat = 12 {
        didSet {
            containerView.layer.cornerRadius = cornerRadius
        }
    }
    
    var backgroundColorType: UIColor = .systemGray6 {
        didSet {
            containerView.backgroundColor = backgroundColorType
        }
    }
    
    var hasOutline: Bool = false {
        didSet {
            updateOutline()
        }
    }
    
    var outlineColor: UIColor = .systemGray3 {
        didSet {
            updateOutline()
        }
    }
    
    var outlineWidth: CGFloat = 1 {
        didSet {
            updateOutline()
        }
    }
    
    var isSecureTextEntry: Bool = false {
        didSet {
            textField.isSecureTextEntry = isSecureTextEntry
            updateEyeButtonVisibility()
        }
    }
    
    // MARK: - Private Properties
    private let titleLabel = UILabel()
    private let containerView = UIView()
    private let textField = UITextField()
    private let errorLabel = UILabel()
    private let eyeButton = UIButton(type: .system)
    private var isPasswordVisible = false
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupConstraints()
    }
    
    // MARK: - Setup Methods
    private func setupView() {
        // Настройка заголовка (справа над полем)
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        titleLabel.textColor = .darkGray
        titleLabel.textAlignment = .right
        titleLabel.isHidden = true
        addSubview(titleLabel)
        
        // Контейнер для текстового поля
        containerView.backgroundColor = backgroundColorType
        containerView.layer.cornerRadius = cornerRadius
        addSubview(containerView)
        
        // Настройка текстового поля
        textField.borderStyle = .none
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        containerView.addSubview(textField)
        
        // Настройка кнопки глазка
        eyeButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        eyeButton.tintColor = .gray
        eyeButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        eyeButton.isHidden = true
        containerView.addSubview(eyeButton)
    }
    
    private func setupConstraints() {
        // Контейнер для поля ввода
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(height)
        }
        
        // Заголовок справа над контейнером
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(containerView.snp.leading)
            make.bottom.equalTo(containerView.snp.top).offset(-10)
        }
        
        // Текстовое поле внутри контейнера
        textField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(eyeButton.snp.leading).offset(-8)
            make.centerY.equalToSuperview()
        }
        
        // Кнопка глазка внутри контейнера
        eyeButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        // Общая высота всего компонента (контейнер + место для заголовка)
        self.snp.makeConstraints { make in
            make.bottom.equalTo(containerView.snp.bottom)
        }
    }
    
    private func updateOutline() {
        if hasOutline {
            containerView.layer.borderWidth = outlineWidth
            containerView.layer.borderColor = outlineColor.cgColor
        } else {
            containerView.layer.borderWidth = 0
            containerView.layer.borderColor = nil
        }
    }
    
    private func updateEyeButtonVisibility() {
        eyeButton.isHidden = !isSecureTextEntry
    }
    
    @objc private func togglePasswordVisibility() {
        isPasswordVisible.toggle()
        textField.isSecureTextEntry = !isPasswordVisible
        
        let eyeImageName = isPasswordVisible ? "eye" : "eye.slash"
        eyeButton.setImage(UIImage(systemName: eyeImageName), for: .normal)
    }
    
    // MARK: - Public Methods
    func setKeyboardType(_ type: UIKeyboardType) {
        textField.keyboardType = type
    }
    
    func setReturnKeyType(_ type: UIReturnKeyType) {
        textField.returnKeyType = type
    }
    
    func setDelegate(_ delegate: UITextFieldDelegate) {
        textField.delegate = delegate
    }
    
    func configureForLogin() {
        title = "Enter your Login"
        placeholder = "Login"
        setKeyboardType(.emailAddress)
    }
    
    func configureForPassword() {
        title = "Enter your Password"
        placeholder = "Password"
        isSecureTextEntry = true
    }
    
    func configureForEmail() {
        title = "Email"
        placeholder = "Email"
        setKeyboardType(.emailAddress)
    }
    
    // MARK: - Error Handling
        func showError(_ message: String) {
            errorLabel.text = message
            errorLabel.isHidden = false
            layer.borderColor = UIColor.red.cgColor
        }
        
        func clearError() {
            errorLabel.text = nil
            errorLabel.isHidden = true
            layer.borderColor = outlineColor.cgColor
        }
}


