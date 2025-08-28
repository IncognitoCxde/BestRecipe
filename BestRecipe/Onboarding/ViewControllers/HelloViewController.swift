//
//  MainViewController.swift
//  homework
//
//  Created by Zarina Sadykova on 21.08.25.
//
import UIKit
import SnapKit

final class HelloViewController: UIViewController {

    private let viewModel: HelloViewModel
    private let bg = BackgroundImageView(imageName: "onboarding1")
    private let gradientOverlay = GradientOverlayView() // Используем кастомный градиент
    
    private let premiumLabel: UILabel = {
        let label = UILabel()
        label.text = "⭐ 100k+ Premium recipes"
        label.textColor = .white
        label.font = UIFont(name: AppFont.Medium, size: 16)
        label.textAlignment = .center
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "BEST \nRECIPE"
        label.textColor = .white
        label.font = UIFont(name: AppFont.Bold, size: 50)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: AppFont.Medium, size: 17)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "Find best recipes for cooking"
        return label
    }()
    
    private let ctaButton = CustomButton(title: "Get started", cornerRadius: 8)
 
    
    init(viewModel: HelloViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Обновляем frame градиента
        gradientOverlay.frame = bg.bounds
    }

    private func buildUI() {
        view.backgroundColor = .black
        
        // Добавляем background
        view.addSubview(bg)
        bg.pinToSuperview()
        
        // Добавляем градиент поверх background
        bg.addSubview(gradientOverlay)
        gradientOverlay.frame = bg.bounds
        
        // Остальные элементы
        view.addSubview(premiumLabel)
        premiumLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.centerX.equalToSuperview()
        }
        
        let stack = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel, ctaButton])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 20
        view.addSubview(stack)
        
        stack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview().multipliedBy(1.45)
        }
        
        ctaButton.snp.makeConstraints { make in
            make.width.greaterThanOrEqualTo(200)
            make.height.equalTo(52)
        }
        
        ctaButton.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
    }
    
    @objc private func continueTapped() {
        viewModel.continueToOnboarding()
    }
}
