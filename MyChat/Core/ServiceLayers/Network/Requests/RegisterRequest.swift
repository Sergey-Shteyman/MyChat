//
//  RegisterRequest.swift
//  MyChat
//
//  Created by Сергей Штейман on 06.12.2022.
//

struct RegisterRequest {
    let accessToken: String
    let body: RegisterBody
}

struct RegisterBody: Encodable {
    let phone: String
    let name: String
    let username: String
}

