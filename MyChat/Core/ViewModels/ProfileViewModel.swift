//
//  ProfileViewModel.swift
//  MyChat
//
//  Created by Сергей Штейман on 06.12.2022.
//

struct ProfileViewModel {
    var name: String
    let birthday: String
    let vk: String
    let instagram: String

    init(
        name: String,
        birthday: String,
        vk: String,
        instagram: String
    ) {
        self.name = name
        self.birthday = birthday
        self.vk = vk
        self.instagram = instagram
    }
    
    init(userModel: UserModel) {
        self.name = userModel.name
        self.birthday = userModel.birthday
        self.vk = userModel.vk
        self.instagram = userModel.instagram
    }
}
