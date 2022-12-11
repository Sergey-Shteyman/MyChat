//
//  NetworkService.swift
//  MyChat
//
//  Created by Сергей Штейман on 06.12.2022.
//

import Alamofire
import Moya

protocol Networkable {
    func request<T: Decodable>(target: APIEndpoint) async throws -> T
}

final class NetworkService {
    private let decoderService: Decoderable

    private lazy var provider = MoyaProvider<APIEndpoint>()

    init(decoderService: Decoderable) {
        self.decoderService = decoderService
    }
}

extension NetworkService: Networkable {
    func request<T: Decodable>(target: APIEndpoint) async throws -> T {
        return try await withCheckedThrowingContinuation { [unowned self] configuretion in
            provider.request(target) { result in
                switch result {
                case let .success(response):
                    switch response.statusCode {
                    case 200...210:
                        configuretion.resume(with: self.decoderService.decode(data: response.data))
                    default:
                        print(response.statusCode)
                        do {
                            let error = try JSONDecoder().decode(ErrorResponse.self, from: response.data)
                            print(error)
                        } catch {
                            print(error, error.localizedDescription)
                        }
                        configuretion.resume(throwing: LocalError.networkCode)
                    }
                case let .failure(error):
                    configuretion.resume(throwing: error)
                }
            }
        }
    }
}
