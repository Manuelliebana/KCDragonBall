import Foundation
@testable import KCDragonBall

class APIClientMock: APIClientProtocol {
    // Propiedades para guardar los resultados que queremos simular
    var receivedJWTResult: Result<String, APIClientError>?
    var receivedHeroResult: Result<[Hero], APIClientError>?
    var receivedTransformationResult: Result<[Transformation], APIClientError>?

    // Propiedad para espiar qué petición se ha hecho
    var receivedRequest: URLRequest?

    // Simula la función de login
    func jwt(_ request: URLRequest, completion: @escaping (Result<String, APIClientError>) -> Void) {
        receivedRequest = request
        if let result = receivedJWTResult {
            completion(result)
        }
    }

    // Simula las peticiones de datos (héroes y transformaciones)
    func request<T: Decodable>(_ request: URLRequest, using: T.Type, completion: @escaping (Result<T, APIClientError>) -> Void) {
        receivedRequest = request
        
        // Comprueba si el tipo esperado es [Hero]
        if T.self is [Hero].Type, let result = receivedHeroResult as? Result<T, APIClientError> {
            completion(result)
        // Comprueba si el tipo esperado es [Transformation]
        } else if T.self is [Transformation].Type, let result = receivedTransformationResult as? Result<T, APIClientError> {
            completion(result)
        }
    }
}


