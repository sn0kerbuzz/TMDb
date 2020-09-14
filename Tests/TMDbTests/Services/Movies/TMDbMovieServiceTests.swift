import Combine
@testable import TMDb
import XCTest

class TMDbMovieServiceTests: XCTestCase {

    var cancellables: Set<AnyCancellable> = []
    var service: TMDbMovieService!
    var apiClient: MockAPIClient!

    let moviePageableList = MoviePageableList(
        page: 1,
        results: [
            Movie(id: 1, title: "Movie 1"),
            Movie(id: 2, title: "Movie 2"),
            Movie(id: 3, title: "Movie 3")
        ],
        totalResults: 3,
        totalPages: 1
    )

    override func setUp() {
        super.setUp()

        apiClient = MockAPIClient()
        service = TMDbMovieService(apiClient: apiClient)
    }

    override func tearDown() {
        apiClient.reset()

        super.tearDown()
    }

    func testFetchDetailsReturnsMovie() {
        let movieID = 1
        let expectedResult = Movie(id: movieID, title: "Some title")

        apiClient.response = expectedResult

        let finished = XCTestExpectation(description: "finished")
        service.fetchDetails(forMovie: movieID)
            .sink(receiveCompletion: { result in
                switch result {
                case .failure:
                    XCTFail("Should not have failed")

                default:
                    break
                }
            }, receiveValue: { result in
                XCTAssertEqual(result, expectedResult)
                finished.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [finished], timeout: 1)

        XCTAssertEqual(apiClient.lastPath, MoviesEndpoint.details(movieID: movieID).url)
    }

    func testFetchCreditsReturnsCredits() {
        let movieID = 1
        let expectedResult = ShowCredits(
            id: movieID,
            cast: [CastMember(id: 2, creditID: "a", name: "Cast 1", character: "Character 1", order: 1)],
            crew: [CrewMember(id: 3, creditID: "b", name: "Crew 1", job: "Job 1", department: "Department 1")])

        apiClient.response = expectedResult

        let finished = XCTestExpectation(description: "finished")
        service.fetchCredits(forMovie: movieID)
            .sink(receiveCompletion: { result in
                switch result {
                case .failure:
                    XCTFail("Should not have failed")

                default:
                    break
                }
            }, receiveValue: { result in
                XCTAssertEqual(result, expectedResult)
                finished.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [finished], timeout: 1)

        XCTAssertEqual(apiClient.lastPath, MoviesEndpoint.credits(movieID: movieID).url)
    }

    func testFetchReviewsReturnsReviews() {
        let movieID = 1
        let expectedResult = ReviewPageableList(
            page: 1,
            results: [Review(id: "2", author: "Author", content: "Some content")],
            totalResults: 2,
            totalPages: 1
        )

        apiClient.response = expectedResult

        let finished = XCTestExpectation(description: "finished")
        service.fetchReviews(forMovie: movieID)
            .sink(receiveCompletion: { result in
                switch result {
                case .failure:
                    XCTFail("Should not have failed")

                default:
                    break
                }
            }, receiveValue: { result in
                XCTAssertEqual(result, expectedResult)
                finished.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [finished], timeout: 1)

        XCTAssertEqual(apiClient.lastPath, MoviesEndpoint.reviews(movieID: movieID).url)
    }

    func testFetchImagesReturnsImageCollection() {
        let movieID = 1
        let expectedResult = ImageCollection(
            id: movieID,
            posters: [ImageMetadata(filePath: URL(string: "/poster.jog")!, width: 10, height: 20)],
            backdrops: [ImageMetadata(filePath: URL(string: "/backgrop.jog")!, width: 50, height: 100)]
        )

        apiClient.response = expectedResult

        let finished = XCTestExpectation(description: "finished")
        service.fetchImages(forMovie: movieID)
            .sink(receiveCompletion: { result in
                switch result {
                case .failure:
                    XCTFail("Should not have failed")

                default:
                    break
                }
            }, receiveValue: { result in
                XCTAssertEqual(result, expectedResult)
                finished.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [finished], timeout: 1)

        XCTAssertEqual(apiClient.lastPath, MoviesEndpoint.images(movieID: movieID).url)
    }

    func testFetchVideosReturnsVideoCollection() {
        let movieID = 1
        let expectedResult = VideoCollection(
            id: movieID,
            results: [
                VideoMetadata(
                    id: "2",
                    name: "Video",
                    site: "YouTube",
                    key: "abc123",
                    type: .trailer,
                    size: .s1080
                )
            ]
        )

        apiClient.response = expectedResult

        let finished = XCTestExpectation(description: "finished")
        service.fetchVideos(forMovie: movieID)
            .sink(receiveCompletion: { result in
                switch result {
                case .failure:
                    XCTFail("Should not have failed")

                default:
                    break
                }
            }, receiveValue: { result in
                XCTAssertEqual(result, expectedResult)
                finished.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [finished], timeout: 1)

        XCTAssertEqual(apiClient.lastPath, MoviesEndpoint.videos(movieID: movieID).url)
    }

    func testFetchRecommendationsReturnsMovies() {
        let movieID = 1
        let expectedResult = moviePageableList
        apiClient.response = expectedResult

        let finished = XCTestExpectation(description: "finished")
        service.fetchRecommendations(forMovie: movieID)
            .sink(receiveCompletion: { result in
                switch result {
                case .failure:
                    XCTFail("Should not have failed")

                default:
                    break
                }
            }, receiveValue: { result in
                XCTAssertEqual(result, expectedResult)
                finished.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [finished], timeout: 1)

        XCTAssertEqual(apiClient.lastPath, MoviesEndpoint.recommendations(movieID: movieID).url)
    }

    func testFetchSimilarReturnsMovies() {
        let movieID = 1
        let expectedResult = moviePageableList
        apiClient.response = expectedResult

        let finished = XCTestExpectation(description: "finished")
        service.fetchSimilar(toMovie: movieID)
            .sink(receiveCompletion: { result in
                switch result {
                case .failure:
                    XCTFail("Should not have failed")

                default:
                    break
                }
            }, receiveValue: { result in
                XCTAssertEqual(result, expectedResult)
                finished.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [finished], timeout: 1)

        XCTAssertEqual(apiClient.lastPath, MoviesEndpoint.similar(movieID: movieID).url)
    }

    func testFetchPopularReturnsMovies() {
        let expectedResult = moviePageableList
        apiClient.response = expectedResult

        let finished = XCTestExpectation(description: "finished")
        service.fetchPopular()
            .sink(receiveCompletion: { result in
                switch result {
                case .failure:
                    XCTFail("Should not have failed")

                default:
                    break
                }
            }, receiveValue: { result in
                XCTAssertEqual(result, expectedResult)
                finished.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [finished], timeout: 1)

        XCTAssertEqual(apiClient.lastPath, MoviesEndpoint.popular().url)
    }

}