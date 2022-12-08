//
//  UserModel.swift
//  MyChat
//
//  Created by Сергей Штейман on 07.12.2022.
//

struct UserModel {
    let name: String
    let username: String
    var birthday: String
    var city: String
    var vk: String
    var instagram: String
    var status: String
    var avatar: UserAvatarModel?
    
    init(
        name: String,
        username: String,
        birthday: String,
        city: String,
        vk: String,
        instagram: String,
        status: String,
        avatar: UserAvatarModel?
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
    
    init(userDBModel: UserDBModel) {
        self.name = userDBModel.name
        self.username = userDBModel.username
        self.birthday = userDBModel.birthday
        self.city = userDBModel.city
        self.vk = userDBModel.vkk
        self.instagram = userDBModel.instagram
        self.status = userDBModel.status
        self.avatar = UserAvatarModel(userAvatarDBModel: userDBModel.avatar)
    }
}
