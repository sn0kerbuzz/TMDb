import Foundation

public struct ProductionCompanyDTO: Identifiable, Decodable, Equatable, LogoURLProviding {

    public let id: Int
    public let name: String
    public let originCountry: String
    public let logoPath: URL?

    public init(id: Int, name: String, originCountry: String, logoPath: URL? = nil) {
        self.id = id
        self.name = name
        self.originCountry = originCountry
        self.logoPath = logoPath
    }

}
