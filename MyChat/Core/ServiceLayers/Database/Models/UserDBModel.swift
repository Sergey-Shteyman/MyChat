//
//  UserDBModel.swift
//  MyChat
//
//  Created by Сергей Штейман on 06.12.2022.
//

import RealmSwift

final class UserDBModel: Object {
    @Persisted var name = ""
    @Persisted var username = ""
    @Persisted var birthday = ""
    @Persisted var city = ""
    @Persisted var vkk = ""
    @Persisted var instagram = ""
    @Persisted var status = ""
    @Persisted var avatar: UserAvatarDBModel?

    convenience init(
        name: String,
        username: String,
        birthday: String,
        city: String,
        vk: String,
        instagram: String,
        status: String,
        avatar: UserAvatarDBModel?
    ) {
        self.init()
        self.name = name
        self.username = username
        self.birthday = birthday
        self.city = city
        self.vkk = vk
        self.instagram = instagram
        self.status = status
        self.avatar = avatar
    }

    convenience init(viewModel: ProfileViewModel) {
        self.init()
        self.name = viewModel.name
    }
}

final class UserAvatarDBModel: Object {
    @Persisted var filename = ""
    @Persisted var base64 = ""

    convenience init(
        filename: String,
        base64: String
    ) {
        self.init()
        self.filename = filename
        self.base64 = base64
    }
}

/*
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
     }
 }
 */

