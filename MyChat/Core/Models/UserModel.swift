//
//  UserModel.swift
//  MyChat
//
//  Created by Сергей Штейман on 07.12.2022.
//

import UIKit

struct UserModel {
    let name: String
    let username: String
    let phone: String
    var birthday: Date?
    var city: String?
    var status: String?
    var horoscope: HoroscopeType
    var avatar: String?
    
    init(
        name: String,
        username: String,
        phone: String,
        birthday: Date?,
        city: String?,
        status: String?,
        horoscope: HoroscopeType,
        avatar: String?
    ) {
        self.name = name
        self.username = username
        self.phone = phone
        self.birthday = birthday
        self.city = city
        self.status = status
        self.horoscope = horoscope
        self.avatar = avatar
    }
    
    init(userDBModel: UserDBModel) {
        self.name = userDBModel.name
        self.username = userDBModel.username
        self.birthday = userDBModel.birthday
        self.city = userDBModel.city
        self.phone = userDBModel.phone
        self.status = userDBModel.status
        self.horoscope = HoroscopeWorker.fetchHoroscope(from: userDBModel.birthday)
        self.avatar = userDBModel.avatar
    }
    
    init(profileData: UserProfileData) {
        self.name = profileData.name
        self.username = profileData.username
        self.birthday = FormatterDate.formatString(profileData.birthday, format: .yyyyMMdd)
        self.city = profileData.city
        self.phone = profileData.phone
        self.status = profileData.status
        self.horoscope = HoroscopeWorker.fetchHoroscope(from: self.birthday)
        self.avatar = profileData.avatar
    }
}
