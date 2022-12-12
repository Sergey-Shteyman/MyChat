//
//  NetworkService.swift
//  MyChat
//
//  Created by Сергей Штейман on 06.12.2022.
//

import Alamofire
import Moya

// MARK: - Networkable
protocol Networkable {
    func request<T: Decodable>(target: APIEndpoint) async throws -> T
}

// MARK: - NetworkService
final class NetworkService {
    private let decoderService: Decoderable
    private let keychainService: Storagable

    private lazy var provider = MoyaProvider<APIEndpoint>()
    
    private let lock = NSLock()
    private var isRefreshing = false

    init(decoderService: Decoderable,
         keychainService: Storagable) {
        self.decoderService = decoderService
        self.keychainService = keychainService
    }
}

// MARK: - Networkable impl
extension NetworkService: Networkable {
    func request<T: Decodable>(target: APIEndpoint) async throws -> T {
        return try await withCheckedThrowingContinuation { [unowned self] configuretion in
            provider.request(target) { result in
                switch result {
                case let .success(response):
                    switch response.statusCode {
                    case 200...210:
                        configuretion.resume(with: self.decoderService.decode(data: response.data))
                    case 401:
                        self.retry(target: target, continuation: configuretion)
                    default:
                        self.printError(response: response)
                        configuretion.resume(throwing: LocalError.networkCode)
                    }
                case let .failure(error):
                    configuretion.resume(throwing: error)
                }
            }
        }
    }
}

// MARK: - NetworkService private methods
private extension NetworkService {
    
    private func refreshToken(_ completion: @escaping (Result<Void, LocalError>) -> Void) {
        lock.lock()
        isRefreshing = true
        defer {
            lock.unlock()
            isRefreshing = false
        }
        do {
            let accessToken = try self.keychainService.fetch(for: .accessToken)
            let refreshToken = try self.keychainService.fetch(for: .refreshToken)
            let body = RefreshBody(refreshToken: refreshToken)
            let request = RefreshRequest(accessToken: accessToken, body: body)
            let completion: (Result<RefreshResponse, LocalError>) -> Void = { [weak self] result in
                guard let self = self else {
                    return
                }
                switch result {
                case let .success(response):
                    do {
                        try self.keychainService.save(response.accessToken, for: .accessToken)
                        try self.keychainService.save(response.refreshToken, for: .refreshToken)
                        completion(.success(Void()))
                    } catch {
                        completion(.failure(LocalError.regular(error)))
                    }
                case let .failure(error):
                    completion(.failure(error))
                }
            }
            self.request(target: .refresh(request: request), completion)
        } catch {
            completion(.failure(LocalError.regular(error)))
        }
    }
    
    func retry<T: Decodable>(target: APIEndpoint, continuation: CheckedContinuation<T, Error>) {
        if isRefreshing {
            continuation.resume(throwing: LocalError.networkIsRefreshing)
        }
        refreshToken { result in
            switch result {
            case .success:
                self.request(target: target) { result in
                    continuation.resume(with: result)
                }
            case .failure:
                continuation.resume(throwing: LocalError.networkRefresh)
            }
        }
    }
    
    func request<T: Decodable>(target: APIEndpoint, _ completion: @escaping (Result<T, LocalError>) -> Void) {
        provider.request(target) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case let .success(response):
                self.decoderService.decode(data: response.data, completion: completion)
            case let .failure(error):
                completion(.failure(LocalError.regular(error)))
            }
        }
    }
    
    func printError(response: Response) {
        do {
            let error: ErrorResponse = try decoderService.decode(data: response.data)
            print("Status code - \(response.statusCode), \(error)")
        } catch {
            print("Status code - \(response.statusCode), \(error), \(error.localizedDescription)")
        }
    }
}
