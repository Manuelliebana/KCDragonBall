import UIKit

class HeroDetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var heroImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var favoriteLabel: UILabel!
    @IBOutlet private weak var transformationsButton: UIButton!
    
    // MARK: - Properties
    private let hero: Hero
    private let token: String
    private let networkModel = NetworkModel(client: APIClient())
    
    // MARK: - Init
    init(hero: Hero, token: String) {
        self.hero = hero
        self.token = token
        super.init(nibName: "HeroDetailViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        checkTransformations()
    }
    
    // MARK: - Setup
    private func setupUI() {
        title = hero.name
        nameLabel.text = hero.name
        descriptionLabel.text = hero.description
        favoriteLabel.text = hero.favorite ? "⭐ Favorito" : ""
        
        // Cargar imagen
        if let url = URL(string: hero.photo) {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let data = data {
                    DispatchQueue.main.async {
                        self.heroImageView.image = UIImage(data: data)
                    }
                }
            }.resume()
        }
    }
    
    // MARK: - Actions
    @IBAction private func transformationsButtonTapped(_ sender: UIButton) {
        let transformationsVC = TransformationListTableViewController(hero: hero, token: token)
        navigationController?.pushViewController(transformationsVC, animated: true)
    }
    
    // MARK: - Private Methods
    private func checkTransformations() {
     // Verificar si el héroe tiene transformaciones
        networkModel.fetchTransformations(heroId: hero.id, token: token) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let transformations):
                    self?.transformationsButton.isHidden = transformations.isEmpty
                case .failure:
                    self?.transformationsButton.isHidden = true
                }
            }
        }
    }
}
