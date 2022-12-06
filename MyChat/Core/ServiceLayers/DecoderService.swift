//
//  DecoderService.swift
//  MyChat
//
//  Created by Сергей Штейман on 06.12.2022.
//

import Foundation

protocol Decoderable {
    func decode<T: Decodable>(data: Data) -> Result<T, Error>
}

final class DecoderService: Decoderable {
    func decode<T: Decodable>(data: Data) -> Result<T, Error> {
        do {
            let result = try JSONDecoder().decode(T.self, from: data)
            return .success(result)
        } catch {
            return .failure(error)
        }
    }
}
