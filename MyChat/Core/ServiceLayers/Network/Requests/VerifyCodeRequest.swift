//
//  VerifyCodeRequest.swift
//  MyChat
//
//  Created by Сергей Штейман on 06.12.2022.
//

struct VerifyCodeRequest {
    let body: VerifyCodeBody
}

struct VerifyCodeBody: Encodable {
    let phone: String
    let code: String
}

