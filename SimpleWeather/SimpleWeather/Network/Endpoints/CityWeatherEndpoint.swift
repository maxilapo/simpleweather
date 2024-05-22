//
//  CityWeatherEndpoint.swift
//  SimpleWeather
//
//  Created by Maxime Lapointe on 2024-01-15.
//

import Foundation

struct CityWeatherEndpoint: EndpointProtocol {
    
    var httpMethod: HTTPMethod = .get
    var path = "/data/3.0/onecall"
    var city: City
    
    var queryItems: [URLQueryItem]? {
        return [URLQueryItem(name: "lat", value: "\(city.latitude)"),
                URLQueryItem(name: "lon", value: "\(city.longitude)"),
                URLQueryItem(name: "exclude", value: "minutely,hourly")]
    }
}
