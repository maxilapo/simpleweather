//
//  Temperature.swift
//  SimpleWeather
//
//  Created by Maxime Lapointe on 2024-01-16.
//

import Foundation

struct Temperature: Codable {
    
    let tempMin: Double
    let tempMax: Double

    enum CodingKeys: String, CodingKey {
        case tempMin = "min"
        case tempMax = "max"
    }
}
