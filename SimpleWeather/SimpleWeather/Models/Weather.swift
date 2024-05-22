//
//  Weather.swift
//  SimpleWeather
//
//  Created by Maxime Lapointe on 2024-01-16.
//

import UIKit

struct Weather: Codable {
    
    let id: Int
    let main: String
    let description: String
    let icon: String
}

extension Weather {
    
    // Return the proper icon for the current weather
    var iconForWeather: UIImage {
        
        switch id {
        case 200...299: // Thunderstorm
                return UIImage(resource: .thunder)
        case 300...399: // Drizzle
            return UIImage(resource: .drizzle)
        case 500...599: // Rain
            return UIImage(resource: .rain)
        case 600...699: // Snow
                return UIImage(resource: .snow)
        case 700...799: // Mist
            return  UIImage(resource: .mist)
        case 800:       // Clear
            return  UIImage(resource: .sun)
        case 701...899: // Clouds
            return  UIImage(resource: .clouds)
        default:
            return UIImage(resource: .unknown)
        }
    }
}
