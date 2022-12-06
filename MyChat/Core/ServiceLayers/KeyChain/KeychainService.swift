//
//  KeychainService.swift
//  MyChat
//
//  Created by Сергей Штейман on 06.12.2022.
//

import KeychainSwift

protocol Storagable {
    func save(_ value: String, for key: KeychainKey) throws
    func fetch(for key: KeychainKey) throws -> String
    func delete(for key: KeychainKey) throws
}

final class KeychainService {
    private let keychain = KeychainSwift()
}

extension KeychainService: Storagable {
    func save(_ value: String, for key: KeychainKey) throws {
        guard keychain.set(value, forKey: key.rawValue, withAccess: .accessibleWhenUnlockedThisDeviceOnly) else {
            throw LocalError.keychainSave
        }
    }
    func fetch(for key: KeychainKey) throws -> String {
        guard let result = keychain.get(key.rawValue) else {
            throw LocalError.keychainFetch
        }
        return result
    }
    func delete(for key: KeychainKey) throws {
        guard keychain.delete(key.rawValue) else {
            throw LocalError.keychainDelete
        }
    }
}
