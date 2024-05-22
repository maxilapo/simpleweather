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
        let roundedValue = (self - 273.15).rounded()

        // MeasurementFormatter
        let celcius = roundedValue == -0.0 ? 0.0 : roundedValue

        return String(format: "%.0f", celcius)
    }
    
    /// Convert from Kelvin to Fahrenheit and return it as a String
    var fahrenheit: String {
        let roundedValue = ((self - 273.15) * 9/5 + 32).rounded()
        let fahr = roundedValue == -0.0 ? 0.0 : roundedValue

        return String(format: "%.0f", fahr)
    }
}
