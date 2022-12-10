//
//  ProfileViewModel.swift
//  MyChat
//
//  Created by Сергей Штейман on 06.12.2022.
//

struct ProfileViewModel {
//    var name: String
//    let birthday: String
//    let vk: String
//    let instagram: String
//
//    init(
//        name: String,
//        birthday: String,
//        vk: String,
//        instagram: String
//    ) {
//        self.name = name
//        self.birthday = birthday
//        self.vk = vk
//        self.instagram = instagram
//    }
//
//    init(userModel: UserModel) {
//        self.name = userModel.name
//        self.birthday = userModel.birthday ?? ""
//        self.vk = userModel.vk ?? ""
//        self.instagram = userModel.instagram ?? ""
//    }
    
    let name: String
    let phone: String
    let status: String?
    let city: String?
    let birthday: String?
    let horoscope: String?
//    let avatar: String?
    
    init(
        name: String,
        phone: String,
        status : String?,
        city: String?,
        birthday: String?,
        horoscope: String?
    ) {
        self.name = name
        self.phone = phone
        self.status = status
        self.city = city
        self.birthday = birthday
        self.horoscope = horoscope
    }
    
    init(userModel: UserModel) {
        self.name = userModel.name
        self.phone = userModel.phone
        self.status = userModel.status
        self.city = userModel.city
        self.birthday = "01.06.1999"//userModel.birthday
        self.horoscope = "Близнецы"//userModel.horoscope
    }
    
//    init(
//        name: String,
//        phone: String,
//        abotMe: String?,
//        city: String?,
//        birthday: String?,
//        horoscope: String?
//    ) {
//        self.name = name
//        self.phone = phone
//        self.abotMe = abotMe
//        self.city = city
//        self.birthday = birthday
//        self.horoscope = horoscope
//    }
//    
//    init(userModel: UserModel) {
//        self.name = userModel.name
//        self.phone = userModel.ph
//    }
}
