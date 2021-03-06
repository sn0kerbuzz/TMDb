import Foundation

public enum MediaDTO: Identifiable, Equatable {

    public var id: Int {
        switch self {
        case .movie(let movie):
            return movie.id

        case .tvShow(let tvShow):
            return tvShow.id

        case .person(let person):
            return person.id
        }
    }

    case movie(MovieDTO)
    case tvShow(TVShowDTO)
    case person(PersonDTO)

}

extension MediaDTO: Decodable {

    private enum CodingKeys: String, CodingKey {
        case mediaType
    }

    private enum MediaType: String, Decodable, Equatable {
        case movie
        case tvShow = "tv"
        case person
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let mediaType = try container.decode(MediaType.self, forKey: .mediaType)

        switch mediaType {
        case .movie:
            self = .movie(try MovieDTO(from: decoder))

        case .tvShow:
            self = .tvShow(try TVShowDTO(from: decoder))

        case .person:
            self = .person(try PersonDTO(from: decoder))
        }
    }

}
