//
//  AuthResponse.swift
//  MyChat
//
//  Created by Сергей Штейман on 06.12.2022.
//

struct AuthResponse: Decodable {
    let isSuccess: Bool

    enum CodingKeys: String, CodingKey {
        case isSuccess = "is_success"
    }
}
