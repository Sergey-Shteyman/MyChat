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
    init(
        name: String,
        username: String,
        birthday: String,
        city: String,
        vk: String,
        instagram: String,
        status: String,
        avatar: UpdateUserAvatar?
    ) {
        self.name = name
        self.username = username
        self.birthday = birthday
        self.city = city
        self.vk = vk
        self.instagram = instagram
        self.status = status
        self.avatar = avatar
    }
    init(userModel: UserModel) {
        self.name = userModel.name
        self.username = userModel.username
        self.birthday = userModel.birthday
        self.city = userModel.city
        self.vk = userModel.vk
        self.instagram = userModel.instagram
        self.status = userModel.status
        self.avatar = UpdateUserAvatar(userAvatarModel: userModel.avatar)
    }
}

struct UpdateUserAvatar: Encodable {
    let filename: String
    let base64: String

    enum CodingKeys: String, CodingKey {
        case base64 = "base_64"
        case filename = "filename"
    }
    
    init(
        filename: String,
        base64: String
    ) {
        self.filename = filename
        self.base64 = base64
    }
    
    init?(userAvatarModel: UserAvatarModel?) {
        guard let filename = userAvatarModel?.filename,
              let base64 = userAvatarModel?.base64
        else {
            return nil
        }
        self.filename = filename
        self.base64 = base64
    }
}
