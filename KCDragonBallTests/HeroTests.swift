import XCTest
@testable import KCDragonBall

final class HeroTests: XCTestCase {

    // Test para verificar la inicialización
    func testHeroInitialization_WhenGivenValues_SetsPropertiesCorrectly() {
        // GIVEN
        let id = "test-id"
        let name = "Goku"
        let description = "El protagonista"
        let photo = "goku.jpg"
        let favorite = true

        // WHEN
        let hero = Hero(id: id, name: name, favorite: favorite, photo: photo, description: description)

        // THEN
        XCTAssertEqual(hero.id, id)
        XCTAssertEqual(hero.name, name)
        XCTAssertEqual(hero.description, description)
        XCTAssertEqual(hero.photo, photo)
        XCTAssertEqual(hero.favorite, favorite)
    }
}
