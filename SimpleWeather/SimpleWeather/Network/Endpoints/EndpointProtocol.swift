//
//  EndpointProtocol.swift
//  SimpleWeather
//
//  Created by Maxime Lapointe on 2024-01-15.
//

import Foundation

enum HTTPMethod: String {
    case get  = "GET"
    case post = "POST"
}

protocol EndpointProtocol {

    var httpMethod: HTTPMethod { get }
    var path: String { get }
    var queryItems: [URLQueryItem]? { get }
}

extension EndpointProtocol {

    /// Return the path of the endpoint (without the special characters)
    /// Used as a key to save the endpoint and his object in the ``CacheManager``
    var keyPath: String? {
        var urlComponents = URLComponents()
        urlComponents.path = path
        urlComponents.queryItems = queryItems

        return urlComponents.url?.absoluteString.alphanumeric
    }
}
