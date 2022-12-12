//
//  ErrorResponse.swift
//  MyChat
//
//  Created by Сергей Штейман on 10.12.2022.
//

import Foundation

struct ErrorResponse: Decodable {
    let detail: [ErrorDetail]?
}

struct ErrorDetail: Decodable {
    let loc: [String]?
    let msg: String?
    let type: String?
}

