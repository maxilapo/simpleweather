//
//  Date+LessThan.swift
//  SimpleWeather
//
//  Created by Maxime Lapointe on 2024-01-16.
//

import Foundation

extension Date {

    /// Check if the Date is older than the ``AppSettings/cacheExpiry``
    func isLessThanCacheExpiry() -> Bool {

        let expieryInSeconds: TimeInterval = AppSettings.cacheExpiry
        let elapsedTime = Date().timeIntervalSince(self)

        return elapsedTime < expieryInSeconds
    }
}
