//
//  MasksValidationFields.swift
//  MyChat
//
//  Created by Сергей Штейман on 01.12.2022.
//

struct MasksValidationFields {
    let validNameField = #"^[A-Z]{1,26}[a-z]{1,26}[0-9]{0,10}[_]{0,2}$"#
    let validPhone = #"^[0-9]{10,10}$"#
    let validCodeSMS = "133337"
}
