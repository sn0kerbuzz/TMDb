import OpenCombine
import Foundation

protocol ConfigurationService {

    func fetchAPIConfiguration() -> AnyPublisher<APIConfigurationDTO, TMDbError>

}
