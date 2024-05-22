//
//  CityWeather.swift
//  SimpleWeather
//
//  Created by Maxime Lapointe on 2024-01-15.
//

import Foundation

struct CityWeather: Codable {
    
    var city: City?
    let current: Current?
    let daily: [Daily]?
    
    enum CodingKeys: String, CodingKey {
        case city
        case current
        case daily
    }
}

struct Current: Codable {
    
    let temp: Double

    enum CodingKeys: String, CodingKey {
        case temp
    }
}

struct Daily: Codable {
    
    let timestamp: Int
    let temperature: Temperature?
    let weather: [Weather]?

    enum CodingKeys: String, CodingKey {
        case timestamp = "dt"
        case temperature = "temp"
        case weather
    }
}
