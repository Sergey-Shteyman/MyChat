//
//  MasksValidationFields.swift
//  MyChat
//
//  Created by Сергей Штейман on 01.12.2022.
//

enum MasksValidationFields {
    static let validNameField = #"^[A-Z]{0,26}[a-z]{1,26}[A-Z]{0,26}[0-9]{0,10}[_]{0,2}$"# //#"^[a-zA-z0-9_]"#
    static let validPhone = #"^[0-9]{10,10}$"#
    static let validCodeSMS = "133337"
}
