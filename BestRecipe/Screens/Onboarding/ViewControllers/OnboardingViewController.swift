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
                pageIndex: index,
                isLastPage: isLastPage,
                onContinue: { [weak self] in
                    self?.handleContinue(at: index)
                },
                onSkip: { [weak self] in
                    self?.viewModel.skip()
                }
            )
            pageVC.delegate = self // Устанавливаем делегат
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
            navigateToPage(index + 1)
        } else {
            viewModel.finish()
        }
    }
    
    private func navigateToPage(_ index: Int) {
        guard index >= 0 && index < pages.count else { return }
        
        let direction: UIPageViewController.NavigationDirection = index > (viewModel.currentIndex) ? .forward : .reverse
        setViewControllers([pages[index]], direction: direction, animated: true)
        viewModel.currentIndex = index
    }
}

// MARK: - OnboardingPageDelegate
extension OnboardingViewController: OnboardingPageDelegate {
    func goToPage(_ index: Int) {
        navigateToPage(index)
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
            viewModel.currentIndex = index
        }
    }
}
