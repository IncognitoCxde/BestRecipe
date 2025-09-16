//
//  OnboardingPageCell.swift
//  homework
//
//  Created by Zarina Sadykova on 23.08.25.
//
import UIKit
import SnapKit

// Протокол для делегата перехода между страницами
protocol OnboardingPageDelegate: AnyObject {
    func goToPage(_ index: Int)
}

final class OnboardingPageViewController: UIViewController {
    
    private let page: OnboardingPage
    private let pageIndex: Int
    private let isLastPage: Bool
    private let onContinue: () -> Void
    private let onSkip: () -> Void
    weak var delegate: OnboardingPageDelegate?
    
    private let bg = BackgroundImageView(imageName: "")
    private let gradientOverlay = GradientOverlayView()
    private let titleLabel = MulticolorTitleLabel()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: AppFont.regular, size: 30)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let actionButton: CustomButton = {
        let button = CustomButton(title: "")
        return button
    }()
    
    private let skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Skip", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: AppFont.medium, size: 14)
        return button
    }()
    
    private let indicatorsView: OnboardingIndicatorsView = {
        let view = OnboardingIndicatorsView()
        return view
    }()
    
    init(page: OnboardingPage, pageIndex: Int, isLastPage: Bool, onContinue: @escaping () -> Void, onSkip: @escaping () -> Void) {
        self.page = page
        self.pageIndex = pageIndex
        self.isLastPage = isLastPage
        self.onContinue = onContinue
        self.onSkip = onSkip
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configure()
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        
        // Background
        view.addSubview(bg)
        bg.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // Gradient overlay
        view.addSubview(gradientOverlay)
        gradientOverlay.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // Stack for text
        let textStack = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        textStack.axis = .vertical
        textStack.spacing = 24
        textStack.alignment = .center
        
        view.addSubview(textStack)
        view.addSubview(actionButton)
        view.addSubview(indicatorsView)
        view.addSubview(skipButton)
        
        // Action button
        actionButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(220)
            make.height.equalTo(52)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-80)
        }

        // Индикаторы над кнопкой
        indicatorsView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(actionButton.snp.top).offset(-40)
            make.width.equalTo(140)
            make.height.equalTo(8)
        }

        // Текстовый стек над индикаторами
        textStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(43)
            make.bottom.equalTo(indicatorsView.snp.top).offset(-20)
        }

        // Skip button
        skipButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-30)
        }
        
        // Add actions
        actionButton.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
        skipButton.addTarget(self, action: #selector(skipTapped), for: .touchUpInside)
        
        // Обработчик тапов на индикаторы
        indicatorsView.onIndicatorTapped = { [weak self] index in
            self?.delegate?.goToPage(index)
        }
    }
    
    private func configure() {
        bg.setImage(named: page.imageName)
        subtitleLabel.text = page.subtitle
        
        // Настраиваем разноцветный текст для каждого экрана
        let thirdColor = UIColor(named: "3rd") ?? .systemOrange
        
        switch pageIndex {
        case 0:
            titleLabel.setText(page.title,
                              coloredParts: [
                                "1": ["over the"],
                                "2": ["World"]
                              ],
                               color: .secondary50)
        case 1:
            titleLabel.setText(page.title,
                              coloredParts: [
                                "1": ["each and every detail"]
                              ],
                               color: .secondary50)
        case 2:
            titleLabel.setText(page.title,
                              coloredParts: [
                                "1": ["save it for later"]
                              ],
                               color: .secondary50)
        default:
            titleLabel.setText(page.title, coloredParts: [:], color: thirdColor)
        }
        
        if isLastPage {
            actionButton.setTitle("Start Cooking", for: .normal)
            actionButton.setCornerRadius(12)
            skipButton.isHidden = true
        } else {
            actionButton.setTitle("Continue", for: .normal)
            actionButton.setCornerRadius(25)
            skipButton.isHidden = false
        }
        
        indicatorsView.setCurrentPage(pageIndex)
    }

    @objc private func continueTapped() {
        onContinue()
    }
    
    @objc private func skipTapped() {
        onSkip()
    }
}
