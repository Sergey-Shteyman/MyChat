//
//  GetUserResponse.swift
//  MyChat
//
//  Created by Сергей Штейман on 06.12.2022.
//

struct GetUserResponse: Decodable {
    let profileData: UserProfileData

    enum CodingKeys: String, CodingKey {
        case profileData = "profile_data"
    }
}

struct UserProfileData: Decodable {
    let name: String
    let username: String
    let birthday: String?
    let city: String?
    let vk: String?
    let instagram: String?
    let status: String?
    let avatar: String?
    let id: Int
    let last: String?
    let online: Bool
    let created: String?
    let phone: String
    let completedTask: Int?
    let avatars: UserAvatar?

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case username = "username"
        case birthday = "birthday"
        case city = "city"
        case vk = "vk"
        case instagram = "instagram"
        case status = "status"
        case avatar = "avatar"
        case id = "id"
        case last = "last"
        case online = "online"
        case created = "created"
        case phone = "phone"
        case completedTask = "completed_task"
        case avatars = "avatars"
    }
}

struct UserAvatar: Decodable {
    let avatar: String?
    let bigAvatar: String
    let miniAvatar: String
}
