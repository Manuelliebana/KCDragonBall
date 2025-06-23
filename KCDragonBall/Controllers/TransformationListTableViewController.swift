import UIKit

class TransformationListTableViewController: UITableViewController {
    
    // MARK: - Properties
    private var transformations: [Transformation] = []
    private let hero: Hero
    private let token: String
    private let networkModel = NetworkModel(client: APIClient())
    
    // MARK: - Init
    init(hero: Hero, token: String) {
        self.hero = hero
        self.token = token
        super.init(nibName: "TransformationListTableViewController", bundle: nil) // Cambiado aquí
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadTransformations()
    }
    
    // MARK: - Setup
    private func setupTableView() {
        let nib = UINib(nibName: "TransformationTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TransformationCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
    }
    
    // MARK: - Data Loading
    private func loadTransformations() {
        networkModel.fetchTransformations(heroId: hero.id, token: token) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let transformations):
                    self?.transformations = transformations
                    self?.tableView.reloadData()
                case .failure(let error):
                    print("Error cargando transformaciones: \(error)")
                }
            }
        }
    }
    
    // MARK: - TableView DataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transformations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TransformationCell", for: indexPath) as? TransformationTableViewCell else {
            return UITableViewCell()
        }
        let transformation = transformations[indexPath.row]
        cell.configure(with: transformation)
        return cell
    }
    
    // MARK: - TableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        _ = transformations[indexPath.row]
    }
}
