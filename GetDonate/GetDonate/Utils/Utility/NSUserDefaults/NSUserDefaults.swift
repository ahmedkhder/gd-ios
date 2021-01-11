//
//  NSUserDefaults.swift
//  Geofencing
//
//  Created by Shiv Kumar on 06/03/18.
//  Copyright © 2018 Shiv Kumar. All rights reserved.
//

import UIKit


class NSUserDefaults: UserDefaults {
    
    private static var userDefaults: UserDefaults = {
        return UserDefaults.standard
    }()
}

//MARK: Extension
extension NSUserDefaults {
    ///- Note: Use for save Codable Model Object
    static func set<T: Encodable>(encodable: T, forKey key: String) {
        if let data = try? JSONEncoder().encode(encodable) {
            standard.set(data, forKey: key)
        }
    }
    /** Return: Use for Retrive Decodable Model Object */
    static func value<T: Decodable>(_ type: T.Type, forKey key: String) -> T? {
        if let data = standard.object(forKey: key) as? Data,
           let value = try? JSONDecoder().decode(type, from: data) {
            return value
        }
        return nil
    }
    ///- Note: Use for save Object
    static func setData(_ value: Any, key: String) {
        let archivedPool = try? NSKeyedArchiver.archivedData(withRootObject: value, requiringSecureCoding: true)
        standard.set(archivedPool, forKey: key)
    }
    static func getData<T>(key: String) -> T? {
        if let val = standard.value(forKey: key) as? Data,
           let obj = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(val) as? T {
            return obj
        }
        return nil
    }
    static public func deleteObject(forKey key: String) {
        standard.removeObject (forKey: key)
        standard.synchronize ()
    }
    
    static public func deleteAllValues () {
        if let bundle = Bundle.main.bundleIdentifier {
            standard.removePersistentDomain(forName: bundle)
            standard.synchronize()
        }
    }
    
    static public func keyExist(_ key: String) -> Bool {
        if standard.object(forKey: key) != nil {
            return true
        }
        return false
    }
}
