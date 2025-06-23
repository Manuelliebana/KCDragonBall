import Foundation

// MARK: - HeroElement
struct Hero: Decodable, Equatable {
    let id: String
    let name: String
    let favorite: Bool
    let photo: String
    let description: String
}
