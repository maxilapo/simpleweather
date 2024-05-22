//
//  CityDetailViewModel.swift
//  SimpleWeather
//
//  Created by Maxime Lapointe on 2024-01-16.
//

import Foundation

class CityDetailViewModel {
    
    var cityWeather: CityWeather
    var nextDaysForecast: [Daily]?
    
    init(cityWeather: CityWeather) {
        self.cityWeather = cityWeather
        
        // First day in Dailies is today so we are removing it
        if let dailies = cityWeather.daily {
            nextDaysForecast = Array(dailies.dropFirst())
        }
    }
}
