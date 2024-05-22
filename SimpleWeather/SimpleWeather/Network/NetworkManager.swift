//
//  NetworkManager.swift
//  SimpleWeather
//
//  Created by Maxime Lapointe on 2024-01-15.
//

import Foundation

final class NetworkManager: DataFetcherProtocol {

    enum NetworkError: Error {
        case invalidURL
        case requestFailed(Error)
        case invalidResponse
        case decodingFailed(Error)
    }
    
    static private let urlScheme = "https"
    static private let urlHost = "api.openweathermap.org"
    static private let apiKeyQueryItem = URLQueryItem(name: "appid", value: AppSettings.apiKey)
        
    /// Fetch data from an ``EndpointProtocol`` and return an object of the provided `T` type
    func fetchData<T: Codable>(from endpoint: EndpointProtocol, as type: T.Type) async throws -> T {
        
        // Creating the request
        guard let urlRequest = buildRequest(with: endpoint),
              let url = urlRequest.url
        else {
            throw NetworkError.invalidURL
        }

        // Performing the request
        let (data, response) = try await URLSession.shared.data(from: url)

        // Throwing if it's not a 2xx response
        guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode)
        else {
            throw NetworkError.invalidResponse
        }
        
        // Decoding and returning the JSON as an object of type T
        do {
            let decodedObject = try JSONDecoder().decode(T.self, from: data)
            CacheManager.save(object: decodedObject, for: endpoint)
            return decodedObject
            
        } catch let decodingError {
            print("‼️ Error decoding: \(decodingError)")
            throw NetworkError.decodingFailed(decodingError)
        }
    }

    // MARK: - Private Methods

    /// Build an URLRequest ready to be perform
    private func buildRequest(with endpoint: EndpointProtocol) -> URLRequest? {

        guard let url = buildUrl(with: endpoint) else { return nil }

        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 30)
        urlRequest.httpMethod = endpoint.httpMethod.rawValue.uppercased()
        urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")

        return urlRequest
    }

    /// Build an URL with components and add query items. Add API key item in the process.
    private func buildUrl(with endpoint: EndpointProtocol) -> URL? {

        var urlComponents = URLComponents()
        urlComponents.scheme = NetworkManager.urlScheme
        urlComponents.host = NetworkManager.urlHost
        urlComponents.path = endpoint.path

        var queryItems = endpoint.queryItems
        queryItems?.append(NetworkManager.apiKeyQueryItem) // Adding the API key to every call
        urlComponents.queryItems = queryItems

        return urlComponents.url
    }
}
