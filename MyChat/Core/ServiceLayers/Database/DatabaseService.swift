//
//  DatabaseService.swift
//  MyChat
//
//  Created by Сергей Штейман on 06.12.2022.
//

import RealmSwift

protocol DatabaseServicable {
    func create<T: Object>(_ object: T) throws
    func read<T: Object>(_ object: T.Type) throws -> Results<T>
    func update<T: Object>(_ object: T, with dictionary: [String: Any?]) throws
    func deleteAll() throws
    func deleteAll(with migration: Migration)
}

final class DatabaseService {
    var realm: Realm {
        do {
            let realm = try Realm(configuration: .defaultConfiguration)
            return realm
        } catch  {
            fatalError("RealmServiceError in instance initialize Realm() - \(error.localizedDescription)")
        }
    }
}

extension DatabaseService: DatabaseServicable {
    func create<T: Object>(_ object: T) throws {
        try realm.write {
            realm.add(object)
        }
    }

    func read<T: Object>(_ object: T.Type) -> Results<T> {
        return realm.objects(T.self)
    }


    func update<T: Object>(_ object: T, with dictionary: [String: Any?]) throws {
        try realm.write {
            for (key, value) in dictionary {
                object.setValue(value, forKey: key)
            }
        }
    }

    func deleteAll() throws {
        try realm.write {
            realm.deleteAll()
        }
    }

    func deleteAll(with migration: Migration) {
        migration.deleteData(forType: String(describing: UserDBModel.self))
        
//        migration.deleteData(forType: String(describing: UserAvatarDBModel.self))
    }
}

