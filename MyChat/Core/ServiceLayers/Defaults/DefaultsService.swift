//
//  DefaultsService.swift
//  MyChat
//
//  Created by Сергей Штейман on 06.12.2022.
//

import Foundation


protocol DefaultServicable {
    func save<T>(_ value: T, forKey key: DefaultsKey)
    func fetchObject<T>(type: T.Type, forKey key: DefaultsKey) -> T?
    func removeObject(forKey key: DefaultsKey)
}

final class DefaultsService: DefaultServicable {
    func save<T>(_ value: T, forKey key: DefaultsKey) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }

    func fetchObject<T>(type: T.Type, forKey key: DefaultsKey) -> T? {
        return UserDefaults.standard.object(forKey: key.rawValue) as? T
    }

    func removeObject(forKey key: DefaultsKey) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
}
