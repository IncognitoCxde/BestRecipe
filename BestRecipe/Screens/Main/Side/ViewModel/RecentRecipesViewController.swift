

import UIKit

class RecentRecipesViewController: UIViewController {

    // MARK: - Variables
    
    let recentTitle = UILabel()
    let recentTableView = UITableView()
#warning("вьюмодель можно передавать через init")
    private let viewModel = SideViewModel()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setUpUI()
    }
    
    // MARK: - UI
    
    private func setUpUI() {
        setupCustomBackButton()
        setUpTitle()
        setUpTrendingTableView()
        configureConstraints()
        bindViewModel()
        
    }
    
    private func setupCustomBackButton() {
        let backButton = UIButton(type: .system)
        let icon = UIImage(systemName: "arrow.left")?.withRenderingMode(.alwaysTemplate)
        backButton.setImage(icon, for: .normal)
        backButton.tintColor = .neutral100
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    // MARK: - Data Centre
    
    func bindViewModel() {
        viewModel.onDataUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.recentTableView.reloadData()
            }
        }
        viewModel.loadMockTrendingData()
    }

#warning("так сейчас не принято, нарушение S + отрыв от самого элемента; из DesignSystem или через замыкание")
    func setUpTitle() {
        recentTitle.text = "Recent recipes"
        recentTitle.font = UIFont(name: AppFont.SemiBold, size: 25)
        recentTitle.textColor = .neutral100
        recentTitle.textAlignment = .center
        view.addSubview(recentTitle)
    }
    
    
    func setUpTrendingTableView() {
        recentTableView.separatorStyle = .none
        recentTableView.backgroundColor = .clear
        recentTableView.delegate = self
        recentTableView.dataSource = self
        recentTableView.register(RecentTableViewCell.self, forCellReuseIdentifier: RecentTableViewCell.identifier)
        view.addSubview(recentTableView)
    }
    
    // MARK: - Constraints
    
    func configureConstraints() {
        recentTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(80)
            make.leading.equalToSuperview().inset(110)
        }
        
        recentTableView.snp.makeConstraints { make in
            make.top.equalTo(recentTitle.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    @objc private func backTapped() {
        navigationController?.popViewController(animated: true)
    }
    
}

// MARK: - Data Source

extension RecentRecipesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.recentRecipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecentTableViewCell.identifier, for: indexPath) as? RecentTableViewCell else {
            return UITableViewCell()
        }
        
        let recipe = viewModel.recentRecipes[indexPath.row]
        cell.configure(with: recipe)
        return cell
    }
    
}

// MARK: - Delegate

extension RecentRecipesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
}
