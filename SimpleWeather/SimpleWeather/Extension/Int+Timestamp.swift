//
//  Int+Timestamp.swift
//  SimpleWeather
//
//  Created by Maxime Lapointe on 2024-01-16.
//

import Foundation

extension Int {
    
    /// Convert an Epoch to the correct WeekDay
    var timestampToWeekday: String {
        
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: date)
        
        let dateFormatter = DateFormatter()
        let weekdaySymbols = dateFormatter.standaloneWeekdaySymbols
        
        return weekdaySymbols?[weekday - 1] ?? "N/A"
    }
}
