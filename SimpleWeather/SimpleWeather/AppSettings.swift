//
//  AppSettings.swift
//  SimpleWeather
//
//  Created by Maxime Lapointe on 2024-01-16.
//

import Foundation

struct AppSettings {

    // Interval before the data is refresh online (seconds)
    static let cacheExpiry: Double = 3600.0

    
    // Used as a query item in urls for identification with the API
    static let apiKey: String = "c97020e6eb8e74673cb9d58b7abaf6eb"
}
