//
//  Double+Kelvin.swift
//  SimpleWeather
//
//  Created by Maxime Lapointe on 2024-01-15.
//

import Foundation

extension Double {
    
    /// Return a temperature based on the metric currently selected
    var currentMetric: String {
        UserDefaults.isCelcius ? celcius : fahrenheit
    }

    /// Convert from Kelvin to Celcius and return it as a String
    var celcius: String {

        let kelvinMeasurement = Measurement(value: self, unit: UnitTemperature.kelvin)
        let celciusValue = kelvinMeasurement.converted(to: .celsius).value.rounded()

        return String(format: "%.0f", celciusValue)
    }
    
    /// Convert from Kelvin to Fahrenheit and return it as a String
    var fahrenheit: String {

        let kelvinMeasurement = Measurement(value: self, unit: UnitTemperature.kelvin)
        let fahrenheitValue = kelvinMeasurement.converted(to: .fahrenheit).value.rounded()
        
        return String(format: "%.0f", fahrenheitValue)
    }
}
