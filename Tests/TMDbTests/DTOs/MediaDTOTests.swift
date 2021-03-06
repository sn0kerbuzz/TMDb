@testable import TMDb
import XCTest

class MediaDTOTests: XCTestCase {

    func testIDWhenMovieReturnsID() {
        XCTAssertEqual(medias[0].id, 1)
    }

    func testIDWhenTVShowReturnsID() {
        XCTAssertEqual(medias[1].id, 2)
    }

    func testIDWhenPersonReturnsID() {
        XCTAssertEqual(medias[2].id, 51329)
    }

    func testDecodeReturnsMedias() throws {
        let data = json.data(using: .utf8)!
        let result = try JSONDecoder.theMovieDatabase.decode([MediaDTO].self, from: data)

        XCTAssertEqual(result, medias)
    }

    private let json = """
    [
        {
            "id": 1,
            "title": "Fight Club",
            "media_type": "movie"
        },
        {
            "id": 2,
            "name": "The Mrs Bradley Mysteries",
            "media_type": "tv"
        },
        {
            "id": 51329,
            "name": "Bradley Cooper",
            "media_type": "person"
        }
    ]
    """

    private let medias: [MediaDTO] = [
        .movie(MovieDTO(id: 1, title: "Fight Club")),
        .tvShow(TVShowDTO(id: 2, name: "The Mrs Bradley Mysteries")),
        .person(PersonDTO(id: 51329, name: "Bradley Cooper"))
    ]

}
