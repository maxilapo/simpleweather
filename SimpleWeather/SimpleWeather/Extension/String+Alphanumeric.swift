//
//  String+Alphanumeric.swift
//  SimpleWeather
//
//  Created by Maxime Lapointe on 2024-01-16.
//

import Foundation

extension String {
 
    /// Removing special characters from a String
    var alphanumeric: String {
        self.components(separatedBy: CharacterSet.alphanumerics.inverted).joined().lowercased()
    }
}
