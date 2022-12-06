//
//  UpdateUserRequest.swift
//  MyChat
//
//  Created by Сергей Штейман on 06.12.2022.
//

struct UpdateUserRequest {
    let accessToken: String
    let body: UpdateUserBody
}

struct UpdateUserBody: Encodable {
    let name: String
    let username: String
    let birthday: String
    let city: String
    let vk: String
    let instagram: String
    let status: String
    let avatar: UpdateUserAvatar?
}

struct UpdateUserAvatar: Encodable {
    let filename: String
    let base64: String

    enum CodingKeys: String, CodingKey {
        case base64 = "base_64"
        case filename = "filename"
    }
}
