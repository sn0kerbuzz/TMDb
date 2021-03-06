import Foundation

public struct TVShowSeasonDTO: Identifiable, Decodable, Equatable, PosterURLProviding {

    public let id: Int
    public let name: String
    public let seasonNumber: Int
    public let overview: String?
    public let airDate: Date?
    public let posterPath: URL?
    public let episodes: [TVShowEpisodeDTO]?

    public init(id: Int, name: String, seasonNumber: Int, overview: String? = nil, airDate: Date? = nil,
                posterPath: URL? = nil, episodes: [TVShowEpisodeDTO]? = nil) {
        self.id = id
        self.name = name
        self.seasonNumber = seasonNumber
        self.overview = overview
        self.airDate = airDate
        self.posterPath = posterPath
        self.episodes = episodes
    }

}
