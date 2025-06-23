import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // Crear la ventana
        window = UIWindow(windowScene: windowScene)
        
        // Crear el controlador inicial (Login)
        let loginViewController = LoginViewController()
        let navigationController = UINavigationController(rootViewController: loginViewController)
        
        // Configurar la ventana
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
