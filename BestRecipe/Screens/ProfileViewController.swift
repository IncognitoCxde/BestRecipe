import UIKit
import PhotosUI

struct PlaceholderItem: Hashable {
    let id = UUID()
}

final class ProfileViewController: UIViewController {
    
    enum Section: Hashable {
        case recipes
    }
    
    private let viewModel: ProfileViewModel
    private let collectionView: UICollectionView
    
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, AnyHashable>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>
    private var dataSource: DataSource!
    
    private let avatar = AvatarView()
    private let nameLabel = UILabel()
    
    init(viewModel: ProfileViewModel = ProfileViewModel()) {
        self.viewModel = viewModel
        
        let layout = UICollectionViewCompositionalLayout { _, _ in
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
        
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCollectionView()
        Task { await reload() }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Task { await reload() }
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        setupNavigationBar()
        setupHeader()
        setupCollectionLayout()
    }
    
    private func setupNavigationBar() {
        title = "My profile"
        
        // Configure navigation bar appearance
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        
        // Set custom title font
        if let font = UIFont(name: AppFont.Bold, size: 24) {
            navigationController?.navigationBar.titleTextAttributes = [
                .font: font,
                .foregroundColor: UIColor.label
            ]
        }
    }
    
    private func setupHeader() {
        avatar.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        nameLabel.text = "My recipes"
        nameLabel.textColor = .label
        
        avatar.setInitials("SR")
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(avatarTapped))
        avatar.addGestureRecognizer(tapGesture)
        avatar.isUserInteractionEnabled = true
        
        view.addSubview(avatar)
        view.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            avatar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            avatar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            avatar.widthAnchor.constraint(equalToConstant: 64),
            avatar.heightAnchor.constraint(equalTo: avatar.widthAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: 24),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -16)
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
    
    private func setupCollectionView() {
        collectionView.backgroundColor = .clear
        collectionView.register(RecipeCardCell.self, forCellWithReuseIdentifier: "RecipeCardCell")
        collectionView.register(PlaceholderCell.self, forCellWithReuseIdentifier: "PlaceholderCell")
        
        dataSource = DataSource(collectionView: collectionView) { [weak self] collectionView, indexPath, item in
            return self?.configureCell(collectionView: collectionView, indexPath: indexPath, item: item)
        }
    }
    
    private func configureCell(collectionView: UICollectionView, indexPath: IndexPath, item: AnyHashable) -> UICollectionViewCell {
        if let viewModel = item as? RecipeCardCell.ViewModel {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeCardCell", for: indexPath) as! RecipeCardCell
            cell.configure(with: viewModel)
            cell.onDeleteTapped = { [weak self] id in
                self?.confirmDelete(id)
            }
            return cell
        } else if item is PlaceholderItem {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlaceholderCell", for: indexPath) as! PlaceholderCell
            cell.configure(with: PlaceholderCell.ViewModel(title: "No recipes yet", ctaTitle: nil))
            return cell
        } else {
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
            snapshot.appendItems([AnyHashable(placeholderItem)])
        } else {
            let viewModels = recipes.map { RecipeCardCell.ViewModel(recipe: $0) }
            snapshot.appendItems(viewModels.map { AnyHashable($0) })
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
