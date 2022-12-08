//
//  UserAvatarModel.swift
//  MyChat
//
//  Created by Сергей Штейман on 07.12.2022.
//

struct UserAvatarModel {
    let filename: String
    let base64: String
    
    init(
        filename: String,
        base64: String
    ) {
        self.filename = filename
        self.base64 = base64
    }
    
    init?(userAvatarDBModel: UserAvatarDBModel?) {
        guard let filename = userAvatarDBModel?.filename,
              let base64 = userAvatarDBModel?.base64
        else {
            return nil
        }
        self.filename = filename
        self.base64 = base64

    }
}
