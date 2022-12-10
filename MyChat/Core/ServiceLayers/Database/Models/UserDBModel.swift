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
    @Persisted var phone = ""
    @Persisted var birthday: Date?
    @Persisted var city: String?
    @Persisted var status: String?
//    @Persisted var avatar: UserAvatarDBModel?

    convenience init(
        name: String,
        username: String,
        birthday: Date,
        city: String,
        status: String
//        avatar: UserAvatarDBModel?
    ) {
        self.init()
        self.name = name
        self.username = username
        self.phone = phone
        self.birthday = birthday
        self.city = city
        self.status = status
//        self.avatar = avatar
    }
    
    convenience init(userModel: UserModel) {
        self.init()
        self.name = userModel.name
        self.username = userModel.username
        self.phone = userModel.phone
        self.birthday = userModel.birthday
        self.city = userModel.city
        self.status = userModel.status
    }
}

//final class UserAvatarDBModel: Object {
//    @Persisted var filename = ""
//    @Persisted var base64 = ""
//
//    convenience init(
//        filename: String,
//        base64: String
//    ) {
//        self.init()
//        self.filename = filename
//        self.base64 = base64
//    }
//
//    convenience init?(userAvatarModel: UserAvatarModel?) {
//        guard let filename = userAvatarModel?.filename,
//              let base64 = userAvatarModel?.base64
//        else {
//            return nil
//        }
//        self.init()
//        self.filename = filename
//        self.base64 = base64
//    }
//}

