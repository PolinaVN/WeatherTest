//
//  RealmManager.swift
//  WeatherTest
//
//  Created by Polina on 27.03.2022.
//

import Foundation
import RealmSwift

final class RealmManager {
    
    //MARK: - Public Properties
    static let deleteIfMigration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
    
    //MARK: - Public Methods
    static func save<T: Object>(items: [T],
                                config: Realm.Configuration = Realm.Configuration.defaultConfiguration,
                                update: Bool = true) {
        //        print(config.fileURL!)
        
        do {
            let realm = try Realm(configuration: self.deleteIfMigration)
            try realm.write {
                realm.add(items)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    static func get<T: Object>(_ type: T.Type,
                               config: Realm.Configuration = Realm.Configuration.defaultConfiguration)
    throws -> Results<T> {
        let realm = try Realm(configuration: self.deleteIfMigration)
        return realm.objects(type)
    }
    
    static func delete<T: Object>(_ items: [T],
                                  config: Realm.Configuration = Realm.Configuration.defaultConfiguration) {
        let realm = try? Realm(configuration: self.deleteIfMigration)
        try? realm?.write {
            realm?.delete(items.self)
        }
    }
}
