//
//  AuthRequest.swift
//  MyChat
//
//  Created by Сергей Штейман on 06.12.2022.
//

struct AuthRequest {
    let body: AuthBody
}

struct AuthBody: Encodable {
    let phone: String
}
