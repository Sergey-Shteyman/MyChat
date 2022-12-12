//
//  RefreshInterceptor.swift
//  MyChat
//
//  Created by Сергей Штейман on 06.12.2022.
//

import Alamofire

final class RefreshInterceptor: RequestInterceptor {
    private let lock = NSLock()
    private var isRefreshing = false
    private var requestsToRetry: [(RetryResult) -> Void] = []

    private let keychainService: Storagable

    init(keychainService: Storagable) {
        self.keychainService = keychainService
    }

    func adapt(
        _ urlRequest: URLRequest,
        for session: Session,
        completion: @escaping (Result<URLRequest, Error>) -> Void
    ) {
        completion(.success(urlRequest))
    }

    func retry(
        _ request: Request,
        for session: Session,
        dueTo error: Error,
        completion: @escaping (RetryResult) -> Void
    ) {
        lock.lock()
        defer {
            lock.unlock()
        }

        guard
            let response = request.task?.response as? HTTPURLResponse,
            response.statusCode == 401
        else {
            completion(.doNotRetry)
            return
        }

        requestsToRetry.append(completion)

        if !isRefreshing {
            Task {
                do {
                    let refreshResponse = try await refreshTokens()

                    try keychainService.save(refreshResponse.accessToken, for: .accessToken)
                    try keychainService.save(refreshResponse.refreshToken, for: .refreshToken)

                    requestsToRetry.forEach { $0(.retry) }
                    requestsToRetry.removeAll()
                } catch {
                    completion(.doNotRetryWithError(error))
                }
            }
        }
    }

    private func refreshTokens() async throws -> RefreshResponse {
        guard !isRefreshing else {
            throw LocalError.refresh
        }

        isRefreshing = true

        let urlString = "https://plannerok.ru/api/v1/users/refresh-token/"
        let accessToken = try keychainService.fetch(for: .accessToken)
        let refreshToken = try keychainService.fetch(for: .refreshToken)
        let headers: HTTPHeaders = [
            HTTPHeader(name: "Authorization", value: "Bearer \(accessToken)")
        ]

        let body = RefreshBody(refreshToken: refreshToken)

        return try await withCheckedThrowingContinuation { [weak self] continuation in
            AF.request(
                urlString,
                method: .post,
                parameters: body,
                encoder: .json,
                headers: headers
            ).response { response in
                if let error = response.error {
                    continuation.resume(throwing: error)
                }

                if let data = response.data {
                    continuation.resume(with: DecoderService().decode(data: data))
                }

                self?.isRefreshing = false
            }
        }
    }
}
