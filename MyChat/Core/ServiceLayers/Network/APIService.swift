//
//  APIService.swift
//  MyChat
//
//  Created by Сергей Штейман on 06.12.2022.
//

protocol APIServiceable {
    func auth(request: AuthRequest) async throws -> AuthResponse
    func verifyCode(request: VerifyCodeRequest) async throws -> VerifyCodeResponse
    func getUser(request: GetUserRequest) async throws -> GetUserResponse
    func updateUser(request: UpdateUserRequest) async throws -> UpdateUserResponse
    func registerUser(request: RegisterRequest) async throws -> RegisterResponse
}

final class APIService {
    private let networkService: Networkable

    init(networkService: Networkable) {
        self.networkService = networkService
    }
}

extension APIService: APIServiceable {
    func auth(request: AuthRequest) async throws -> AuthResponse {
        try await networkService.request(target: .auth(request: request))
    }

    func verifyCode(request: VerifyCodeRequest) async throws -> VerifyCodeResponse {
        try await networkService.request(target: .verifyCode(request: request))
    }

    func getUser(request: GetUserRequest) async throws -> GetUserResponse {
        try await networkService.request(target: .getUser(request: request))
    }

    func refresh(request: RefreshRequest) async throws -> RefreshResponse {
        try await networkService.request(target: .refresh(request: request))
    }

    func updateUser(request: UpdateUserRequest) async throws -> UpdateUserResponse {
        try await networkService.request(target: .updateUser(request: request))
    }

    func registerUser(request: RegisterRequest) async throws -> RegisterResponse {
        try await networkService.request(target: .register(request: request))
    }
}

