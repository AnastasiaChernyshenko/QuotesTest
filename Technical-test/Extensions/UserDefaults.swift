//
//  UserDefaults.swift
//  Technical-test
//
//  Created by mac on 28.03.2023.
//

import Foundation

private let encoder = JSONEncoder()
private let decoder = JSONDecoder()

extension UserDefaults {
    enum Key: String {
        case favouriteQuoteNames = "FAVOURITE_QUOTE_NAMES"
    }
    
    subscript<T>(key: Key) -> T? {
        get {
            return value(forKey: key.rawValue) as? T
        }
        set {
            set(newValue, forKey: key.rawValue)
        }
    }
    
    var favouriteQuoteNames: Set<String> {
        get {
            do {
                return try PropertyListDecoder().decode(Set<String>.self, from: self[.favouriteQuoteNames] ?? Data())
            } catch _ {
                return []
            }
        }
        set {
            self[.favouriteQuoteNames] = try? PropertyListEncoder().encode(newValue)
        }
    }
}
