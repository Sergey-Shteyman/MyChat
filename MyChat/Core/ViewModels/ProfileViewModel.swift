//
//  ProfileViewModel.swift
//  MyChat
//
//  Created by Сергей Штейман on 06.12.2022.
//


struct ProfileViewModel {
    
    let name: String
    let phone: String
    let status: String?
    let city: String?
    let birthday: String?
    let horoscope: HoroscopeType
    let avatar: String?
    
    init(
        name: String,
        phone: String,
        status : String?,
        city: String?,
        birthday: String?,
        horoscope: HoroscopeType,
        avatar: String?
    ) {
        self.name = name
        self.phone = phone
        self.status = status
        self.city = city
        self.birthday = birthday
        self.horoscope = horoscope
        self.avatar = avatar
    }
    
    init(userModel: UserModel) {
        self.name = userModel.name
        self.phone = userModel.phone
        self.status = userModel.status
        self.city = userModel.city
        self.birthday = FormatterDate.formatDate(userModel.birthday, format: .ddMMyyyy)
        self.horoscope = HoroscopeWorker.fetchHoroscope(from: userModel.birthday)
        self.avatar = userModel.avatar
    }
}
