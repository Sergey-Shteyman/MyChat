//
//  RefreshRequest.swift
//  MyChat
//
//  Created by Сергей Штейман on 06.12.2022.
//

struct RefreshRequest {
    let accessToken: String
    let body: RefreshBody
}

struct RefreshBody: Encodable {
    let refreshToken: String

    enum CodingKeys: String, CodingKey {
        case refreshToken = "refresh_token"
    }
}

