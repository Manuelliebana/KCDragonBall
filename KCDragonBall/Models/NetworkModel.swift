import Foundation

final class NetworkModel {
    
    private var baseComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "dragonball.keepcoding.education"
        return components
    }
    
    private let client: APIClientProtocol
    
    init(client: APIClientProtocol) {
        self.client = client
    }
    
    func login(
        user: String,
        password: String,
        completion: @escaping (Result<String, APIClientError>) -> Void) {
        
        // Configurar la URL
        var components = baseComponents
        components.path = "/api/auth/login"
            
        guard let url = components.url else {
            completion(.failure(.malformedURL))
            return
            
        }
            
        // Voy a crear un string tal que usuario:contraseña
        let loginString = String(format: "%@:%@", user, password)
            
        
        // Encodifico el loginString con utf8
        guard let loginData = loginString.data(using: .utf8) else {
            completion(.failure(.decodingFailed))
            return
        }
            
        let base64LoginData = loginData.base64EncodedString()
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Basic \(base64LoginData)", forHTTPHeaderField: "Authorization")
        
            
        client.jwt(request, completion: completion)
            
    }
    
    func fetchHeroes(
        token: String,
        completion: @escaping (Result<[Hero], APIClientError>) -> Void
    ) {
        var components = baseComponents
        components.path = "/api/heros/all"
        guard let url = components.url else {
            completion(.failure(.malformedURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        request.httpBody = try? JSONSerialization.data(withJSONObject: ["name": ""])

        client.request(request, using: [Hero].self, completion: completion)
    }
    
    func fetchTransformations(
        heroId: String,
        token: String,
        completion: @escaping (Result<[Transformation], APIClientError>) -> Void
    ) {
        var components = baseComponents
        components.path = "/api/heros/tranformations"
        guard let url = components.url else {
            completion(.failure(.malformedURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // El body debe ser un JSON con el id del héroe
        let body: [String: String] = ["id": heroId]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        client.request(request, using: [Transformation].self, completion: completion)
    }
}
