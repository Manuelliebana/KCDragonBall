import UIKit

class TransformationTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet private weak var transformationImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    // MARK: - Configure
    func configure(with transformation: Transformation) {
        nameLabel.text = transformation.name
        descriptionLabel.text = transformation.description
        
        // Cargar imagen de forma asíncrona
        if let url = URL(string: transformation.photo) {
            URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                if error != nil {
                    return
                }
                guard let data = data, let image = UIImage(data: data) else {
                    return
                }
                DispatchQueue.main.async {
                    self?.transformationImageView.image = image
                }
            }.resume()
        } else {
            transformationImageView.image = nil
        }
    }
}
