//
//  VerifyCodeResponse.swift
//  MyChat
//
//  Created by Сергей Штейман on 06.12.2022.
//

struct VerifyCodeResponse: Decodable {
    let refreshToken: String
    let accessToken: String
    let userID: Int
    let isUserExists: Bool

    enum CodingKeys: String, CodingKey {
        case refreshToken = "refresh_token"
        case accessToken = "access_token"
        case userID = "user_id"
        case isUserExists = "is_user_exists"
    }
}
