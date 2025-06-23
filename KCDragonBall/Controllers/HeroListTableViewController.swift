import UIKit

class HeroListTableViewController: UITableViewController {
    
    // MARK: - Properties
    private var heroes: [Hero] = []
    private let networkModel = NetworkModel(client: APIClient())
    private var token: String
    
    // MARK: - Init
    init(token: String) {
        self.token = token
        super.init(nibName: "HeroListTableViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadHeroes()
    }
    
    // MARK: - Setup
    private func setupTableView() {
        let nib = UINib(nibName: "HeroTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "HeroCell")
        tableView.rowHeight = 80
    }
    
    // MARK: - Data Loading
    private func loadHeroes() {
        networkModel.fetchHeroes(token: token) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let heroes):
                    self?.heroes = heroes
                    self?.tableView.reloadData()
                case .failure(let error):
                    print("Error cargando héroes: \(error)")
                }
            }
        }
    }
    
    // MARK: - TableView DataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HeroCell", for: indexPath) as? HeroTableViewCell else {
            return UITableViewCell()
        }
        let hero = heroes[indexPath.row]
        cell.configure(with: hero)
        return cell
    }
    
    // MARK: - TableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let hero = heroes[indexPath.row]
        
        let detailVC = HeroDetailViewController(hero: hero, token: token)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

