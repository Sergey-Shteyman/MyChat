//
//  RegisterResponse.swift
//  MyChat
//
//  Created by Сергей Штейман on 06.12.2022.
//

// TODO: - есть точно такойже респонсе, стоит заменить на 1
struct RegisterResponse: Decodable {
    let refreshToken: String
    let accessToken: String
    let userID: Int?

    enum CodingKeys: String, CodingKey {
        case refreshToken = "refresh_token"
        case accessToken = "access_token"
        case userID = "user_id"
    }
}

