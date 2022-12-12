//
//  DecoderService.swift
//  MyChat
//
//  Created by Сергей Штейман on 06.12.2022.
//

import Foundation

protocol Decoderable {
    func decode<T: Decodable>(data: Data) -> Result<T, Error>
    func decode<T: Decodable>(data: Data, completion: @escaping (Result<T, LocalError>) -> Void)
    func decode<T: Decodable>(data: Data) throws -> T
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
    
    func decode<T: Decodable>(data: Data, completion: @escaping (Result<T, LocalError>) -> Void) {
        do {
            let result = try JSONDecoder().decode(T.self, from: data)
            completion(.success(result))
        } catch {
            completion(.failure(LocalError.regular(error)))
        }
    }
    
    func decode<T: Decodable>(data: Data) throws -> T {
        try JSONDecoder().decode(T.self, from: data)
    }
}
