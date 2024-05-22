//
//  UserDefaults+Accessors.swift
//  SimpleWeather
//
//  Created by Maxime Lapointe on 2024-01-16.
//

import Foundation

extension UserDefaults {

    private enum Keys {
        static let lastOnlineFetch = "lastOnlineFetch"
        static let isCelcius = "isCelcius"
    }

    /// Used to handle the last date the cache was updated (last online fetch)
    class var lastOnlineFetch: Date? {
        get { return UserDefaults.standard.object(forKey: Keys.lastOnlineFetch) as? Date }
        set { UserDefaults.standard.setValue(newValue, forKey: Keys.lastOnlineFetch) }
    }

    /// Used to store the metric the user want to use (Celcius vs Fahrenheit)
    class var isCelcius: Bool {
        get { return UserDefaults.standard.bool(forKey: Keys.isCelcius) }
        set { UserDefaults.standard.set(newValue, forKey: Keys.isCelcius) }
    }
}
