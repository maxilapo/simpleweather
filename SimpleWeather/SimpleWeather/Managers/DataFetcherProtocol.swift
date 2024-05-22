//
//  DataFetcherProtocol.swift
//  SimpleWeather
//
//  Created by Maxime Lapointe on 2024-01-16.
//

import Foundation

protocol DataFetcherProtocol {

    /// Used to fetch the object of Type T of an ``EndpointProtocol``
    func fetchData<T: Codable>(from endpoint: EndpointProtocol, as type: T.Type) async throws -> T
}
