//
//  OnboardingViewController.swift
//  homework
//
//  Created by Zarina Sadykova on 22.08.25.
//
import UIKit

final class OnboardingViewController: UIPageViewController {
    
    private let viewModel: OnboardingViewModel
    private var pages: [UIViewController] = []
    private let indicatorsView = OnboardingIndicatorsView()
    
    init(viewModel: OnboardingViewModel) {
        self.viewModel = viewModel
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPages()
        setupAppearance()
    }
    
    private func setupPages() {
            // Создаем страницы
            for (index, page) in viewModel.pages.enumerated() {
                let isLastPage = index == viewModel.pages.count - 1
                let pageVC = OnboardingPageViewController(
                    page: page,
                    pageIndex: index, // Передаем индекс страницы
                    isLastPage: isLastPage,
                    onContinue: { [weak self] in
                        self?.handleContinue(at: index)
                    },
                    onSkip: { [weak self] in
                        self?.viewModel.skip()
                    }
                )
                pages.append(pageVC)
            }
            
            // Устанавливаем первую страницу
            if let firstPage = pages.first {
                setViewControllers([firstPage], direction: .forward, animated: true)
            }
            
            dataSource = self
            delegate = self
        }
    
    
    private func setupAppearance() {
        view.backgroundColor = .black
    }
    
    private func handleContinue(at index: Int) {
        if index < pages.count - 1 {
            // Переход к следующей странице
            let nextPage = pages[index + 1]
            setViewControllers([nextPage], direction: .forward, animated: true)
            indicatorsView.setCurrentPage(index + 1)
        } else {
            // Завершение онбординга
            viewModel.finish()
        }
    }
    
    // Анимированное обновление индикаторов
    private func updateIndicators(for page: Int) {
        UIView.animate(withDuration: 0.3) {
            self.indicatorsView.setCurrentPage(page)
        }
    }
}

// MARK: - UIPageViewControllerDataSource
extension OnboardingViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index > 0 else {
            return nil
        }
        return pages[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index < pages.count - 1 else {
            return nil
        }
        return pages[index + 1]
    }
}

// MARK: - UIPageViewControllerDelegate
extension OnboardingViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let currentVC = viewControllers?.first,
           let index = pages.firstIndex(of: currentVC) {
            updateIndicators(for: index)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        // Можно добавить предварительную анимацию индикаторов
    }
}
