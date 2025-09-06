import UIKit
import PhotosUI

struct PlaceholderItem: Hashable, Sendable {
    let id = UUID()
}

final class ProfileViewController: UIViewController {
    
    enum Section: Hashable, Sendable {
        case recipes
    }
    
    enum CollectionItem: Hashable, Sendable {
        case recipe(RecipeCardCell.ViewModel)
        case placeholder(PlaceholderItem)
    }
    
    // MARK: - Properties
    private let viewModel: ProfileViewModel
    private let collectionView: UICollectionView
    private let avatar = AvatarView()
    private let nameLabel = UILabel()
    private let profileTitleLabel = UILabel()
    
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, CollectionItem>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, CollectionItem>
    private var dataSource: DataSource!
    
    // MARK: - Initialization
    init(viewModel: ProfileViewModel = ProfileViewModel(), persistenceService: PersistenceService = InMemoryPersistenceService.shared) {
        self.viewModel = ProfileViewModel(persistence: persistenceService)
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { nil }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.collectionViewLayout = createRecipesLayout()
        setupUI()
        setupCollectionView()
        setNeedsStatusBarAppearanceUpdate()
        Task { await reload() }
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Task { await reload() }
    }
    
    // MARK: - Setup
    private func setupUI() {
        view.backgroundColor = .systemBackground
        setupNavigationBar()
        setupHeader()
        setupCollectionLayout()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func setupHeader() {
        avatar.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        profileTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        profileTitleLabel.font = UIFont(name: AppFont.SemiBold, size: 24) ?? .systemFont(ofSize: 24, weight: .semibold)
        profileTitleLabel.text = "My Profile"
        profileTitleLabel.textColor = .label
        
        nameLabel.font = UIFont(name: AppFont.SemiBold, size: 24) ?? .systemFont(ofSize: 24, weight: .semibold)
        nameLabel.text = "My recipes"
        nameLabel.textColor = .label
        
        avatar.setInitials("SR")
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(avatarTapped))
        avatar.addGestureRecognizer(tapGesture)
        avatar.isUserInteractionEnabled = true
        
        view.addSubview(avatar)
        view.addSubview(nameLabel)
        view.addSubview(profileTitleLabel)
        
        NSLayoutConstraint.activate([
            profileTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            profileTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            // Аватарка - размер 100x100px, отступ сверху до заголовка 32px
            avatar.topAnchor.constraint(equalTo: profileTitleLabel.bottomAnchor, constant: 32),
            avatar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            avatar.widthAnchor.constraint(equalToConstant: 100),
            avatar.heightAnchor.constraint(equalToConstant: 100),
            
            // "My recipes" - отступ сверху до аватарки 68px, слева 36px
            nameLabel.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: 68),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupCollectionLayout() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func createRecipesLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { _, _ in
            let item = NSCollectionLayoutItem(
                layoutSize: .init(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(200)
                )
            )
            
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: .init(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(200)
                ),
                subitems: [item]
            )
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = .init(top: 0, leading: 16, bottom: 25, trailing: 16)
            section.interGroupSpacing = 25
            
            return section
        }
    }
    
    private func setupCollectionView() {
        collectionView.backgroundColor = .clear
        collectionView.register(RecipeCardCell.self, forCellWithReuseIdentifier: "RecipeCardCell")
        collectionView.register(PlaceholderCell.self, forCellWithReuseIdentifier: "PlaceholderCell")
        
        dataSource = DataSource(collectionView: collectionView) { [weak self] collectionView, indexPath, item in
            return self?.configureCell(collectionView: collectionView, indexPath: indexPath, item: item)
        }
    }
    
    private func configureCell(collectionView: UICollectionView, indexPath: IndexPath, item: CollectionItem) -> UICollectionViewCell {
        switch item {
        case .recipe(let viewModel):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeCardCell", for: indexPath) as! RecipeCardCell
            cell.configure(with: viewModel)
            cell.onDeleteTapped = { [weak self] id in
                self?.confirmDelete(id)
            }
            return cell
        case .placeholder(_):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlaceholderCell", for: indexPath) as! PlaceholderCell
            cell.configure(with: PlaceholderCell.ViewModel(title: "No recipes yet", ctaTitle: nil))
            return cell
        }
    }
    
    @objc private func avatarTapped() {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 1
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        present(picker, animated: true)
    }
    
    private func confirmDelete(_ id: UUID) {
        let alert = UIAlertController(title: "Delete Recipe", message: "Are you sure you want to delete this recipe?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
            Task {
                try? await self?.viewModel.deleteRecipe(id)
                await self?.reload()
            }
        })
        
        present(alert, animated: true)
    }
    
    @MainActor
    private func reload() async {
        let recipes = await viewModel.loadRecipes()
        updateSnapshot(with: recipes)
    }
    
    private func updateSnapshot(with recipes: [Recipe]) {
        var snapshot = Snapshot()
        snapshot.appendSections([.recipes])
        
        if recipes.isEmpty {
            let placeholderItem = PlaceholderItem()
            snapshot.appendItems([.placeholder(placeholderItem)])
        } else {
            let items = recipes.map { recipe in
                CollectionItem.recipe(RecipeCardCell.ViewModel(recipe: recipe))
            }
            snapshot.appendItems(items)
        }
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension ProfileViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        guard let result = results.first else { return }
        
        if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
            result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] object, _ in
                guard let self = self, let image = object as? UIImage else { return }
                
                DispatchQueue.main.async {
                    self.avatar.setImage(image)
                }
            }
        }
    }
}

final class ProfileViewModel {
    
    private let persistence: PersistenceService
    
    init(persistence: PersistenceService = InMemoryPersistenceService.shared) {
        self.persistence = persistence
    }
    
    func loadRecipes() async -> [Recipe] {
        do {
            return try await persistence.loadRecipes()
        } catch {
            print("Error loading recipes: \(error)")
            return []
        }
    }
    
    func deleteRecipe(_ id: UUID) async throws {
        try await persistence.deleteRecipe(id: id)
    }
}
