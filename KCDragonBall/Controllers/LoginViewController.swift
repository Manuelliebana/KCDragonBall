import UIKit

class LoginViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginButton: UIButton!

    // MARK: - Inits
    private let networkModel = NetworkModel(client: APIClient())

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - IBActions
    @IBAction func loginButtonTapped(_ sender: Any) {
        // 1. Validar que los campos no están vacíos
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            // Mostrar un error al usuario si los campos están vacíos
            let alert = UIAlertController(
                title: "Campos vacíos",
                message: "Email o contraseña no pueden estar vacíos",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        
        // 2. Desactivar el botón para evitar múltiples toques
        loginButton.isEnabled = false

        // 3. Realizar la llamada de login
        networkModel.login(user: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                self?.loginButton.isEnabled = true
                
                switch result {
                case .success(let token):
                    // ¡Login exitoso!
                    print("Login correcto. Token: \(token)")
                    // NAVEGAR a la lista de héroes
                    let heroListVC = HeroListTableViewController(token: token)
                    self?.navigationController?.pushViewController(heroListVC, animated: true)
                    
                case .failure:
                    // Error en el login
                    let alert = UIAlertController(
                        title: "Error de Login",
                        message: "Usuario o contraseña incorrectos",
                        preferredStyle: .alert
                    )
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self?.present(alert, animated: true)
                }
            }
        }
    }
}
