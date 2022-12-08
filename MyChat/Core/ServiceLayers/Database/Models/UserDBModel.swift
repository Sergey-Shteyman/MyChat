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

    convenience init(userModel: UserModel) {
        self.init()
        self.name = userModel.name
        self.username = userModel.username
        self.birthday = userModel.birthday
        self.city = userModel.city
        self.vkk = userModel.vk
        self.instagram = userModel.instagram
        self.status = userModel.status
        self.avatar = UserAvatarDBModel(userAvatarModel: userModel.avatar)
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
    
    convenience init?(userAvatarModel: UserAvatarModel?) {
        guard let filename = userAvatarModel?.filename,
              let base64 = userAvatarModel?.base64
        else {
            return nil
        }
        self.init()
        self.filename = filename
        self.base64 = base64
    }
}

