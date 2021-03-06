import Combine
@testable import TMDb
import XCTest

class MockAPIClient: APIClient {

    static var apiKey: String?

    var response: Any?
    private(set) var lastPath: URL?
    private(set) var lastHTTPHeaders: [String: String]?

    static func setAPIKey(_ apiKey: String) {
        Self.apiKey = apiKey
    }

    func get<Response: Decodable>(path: URL, httpHeaders: [String: String]?) -> AnyPublisher<Response, TMDbError> {
        self.lastPath = path
        self.lastHTTPHeaders = httpHeaders

        guard let result = response as? Response else {
            XCTFail("Can't cast response to type \(String(describing: Response.self))")
            return Empty()
                .setFailureType(to: TMDbError.self)
                .eraseToAnyPublisher()
        }

        return Just(result)
            .setFailureType(to: TMDbError.self)
            .eraseToAnyPublisher()
    }

    func reset() {
        response = nil
        lastPath = nil
        lastHTTPHeaders = nil
    }

}
