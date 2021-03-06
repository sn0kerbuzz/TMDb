import Combine
import Foundation

final class TMDbSearchService: SearchService {

    private let apiClient: APIClient

    init(apiClient: APIClient = TMDbAPIClient.shared) {
        self.apiClient = apiClient
    }

    func searchAll(query: String, page: Int?) -> AnyPublisher<MediaPageableListDTO, TMDbError> {
        apiClient.get(endpoint: SearchEndpoint.multi(query: query, page: page))
    }

    func searchMovies(query: String, year: Int?, page: Int?) -> AnyPublisher<MoviePageableListDTO, TMDbError> {
        apiClient.get(endpoint: SearchEndpoint.movies(query: query, year: year, page: page))
    }

    func searchTVShows(query: String, firstAirDateYear: Int?,
                       page: Int?) -> AnyPublisher<TVShowPageableListDTO, TMDbError> {
        apiClient.get(endpoint: SearchEndpoint.tvShows(query: query, firstAirDateYear: firstAirDateYear, page: page))
    }

    func searchPeople(query: String, page: Int?) -> AnyPublisher<PersonPageableListDTO, TMDbError> {
        apiClient.get(endpoint: SearchEndpoint.people(query: query, page: page))
    }

}
