import XCTest
@testable import KCDragonBall

final class TransformationTests: XCTestCase {

    // Test para verificar la inicialización del modelo Transformation
    func testTransformationInitialization_SetsPropertiesCorrectly() {
        // GIVEN: Los datos para una transformación de prueba.
        let id = "t1"
        let name = "Super Saiyan"
        let photo = "ssj.jpg"
        let description = "Pelo amarillo"
        
        let transformation = Transformation(
            id: id,
            name: name,
            photo: photo,
            description: description
        )
        
        // THEN: Verificamos que todas las propiedades se han asignado correctamente.
        XCTAssertEqual(transformation.id, id)
        XCTAssertEqual(transformation.name, name)
        XCTAssertEqual(transformation.photo, photo)
        XCTAssertEqual(transformation.description, description)
    }
    
    // Test para verificar la decodificación desde JSON
    func testTransformationModel_CanBeDecodedFromJson() throws {
        // GIVEN: Un JSON que coincide con la estructura del modelo
        let jsonString = """
        {
            "id": "t1",
            "name": "Super Saiyan",
            "description": "Pelo amarillo",
            "photo": "ssj-photo-url"
        }
        """
        let jsonData = Data(jsonString.utf8)
        
        // WHEN
        let transformation = try JSONDecoder().decode(Transformation.self, from: jsonData)
        
        // THEN
        XCTAssertEqual(transformation.name, "Super Saiyan")
        XCTAssertEqual(transformation.id, "t1")
    }
}
