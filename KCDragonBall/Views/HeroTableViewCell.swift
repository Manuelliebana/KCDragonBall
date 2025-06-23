import UIKit

class HeroTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet private weak var heroImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    // MARK: - Configure
    func configure(with hero: Hero) {
        nameLabel.text = hero.name
        descriptionLabel.text = hero.description
        
        // Cargar imagen de forma asíncrona
        if let url = URL(string: hero.photo) {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let data = data {
                    DispatchQueue.main.async {
                        self.heroImageView.image = UIImage(data: data)
                    }
                }
            }.resume()
        } else {
            heroImageView.image = nil
        }
    }
}
