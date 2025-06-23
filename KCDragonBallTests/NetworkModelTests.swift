import XCTest
@testable import KCDragonBall

final class NetworkModelTests: XCTestCase {
    private var sut: NetworkModel!
    private var apiClient: APIClientMock!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        apiClient = APIClientMock()
        sut = NetworkModel(client: apiClient)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        apiClient = nil
        try super.tearDownWithError()
    }
    
    // MARK: - Requisito: Test para el Login
    func testLogin_WhenSuccessful_ReturnsToken() {
        // GIVEN
        let expectedToken = "fake-jwt-token-from-test"
        apiClient.receivedJWTResult = .success(expectedToken)
        let expectation = self.expectation(description: "Login completes")

        // WHEN
        sut.login(user: "test@user.com", password: "123") { result in
            // THEN
            switch result {
            case .success(let receivedToken):
                XCTAssertEqual(receivedToken, expectedToken, "El token recibido no es el esperado.")
                // Verificamos que se llamó a la URL correcta
                XCTAssertEqual(self.apiClient.receivedRequest?.url?.absoluteString, "https://dragonball.keepcoding.education/api/auth/login")
            case .failure:
                XCTFail("El login debería haber sido exitoso.")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
    
    // MARK: - Requisito: Test para getTransformations
    func testGetTransformations_WhenSuccessful_ReturnsTransformations() {
        // GIVEN
        // Ya no necesitamos un 'goku' aquí. Creamos las transformaciones sin el héroe.
        let expectedTransformations = [
            Transformation(id: "t1", name: "Super Saiyan", photo: "", description: "Pelo amarillo")
        ]
        apiClient.receivedTransformationResult = .success(expectedTransformations)
        let expectation = self.expectation(description: "Fetch transformations completes")
        
        // WHEN
        sut.fetchTransformations(heroId: "some-id", token: "some-token") { result in
            // THEN
            switch result {
            case .success(let receivedTransformations):
                XCTAssertEqual(receivedTransformations, expectedTransformations)
            case .failure:
                XCTFail("La obtención de transformaciones debería haber sido exitosa.")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
}
