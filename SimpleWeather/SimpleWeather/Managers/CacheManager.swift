//
//  CacheManager.swift
//  SimpleWeather
//
//  Created by Maxime Lapointe on 2024-01-16.
//

import Foundation

final class CacheManager {

    /// Save a Codable object in the cache, using the ``EndpointProtocol/keyPath`` as filename
    static func save<T: Codable>(object: T, for endpoint: EndpointProtocol) {

        guard let endpointPath = endpoint.keyPath else { return }
        
        let filepath = documentsDirectory(with: endpointPath)

        do {
            let archiver = NSKeyedArchiver(requiringSecureCoding: false)
            archiver.outputFormat = .binary
            try archiver.encodeEncodable(object, forKey: NSKeyedArchiveRootObjectKey)
            archiver.finishEncoding ()
            try archiver.encodedData.write(to: filepath)
            UserDefaults.lastOnlineFetch = Date()
        }
        catch let error {
            print("‼️ Failed to save \(endpointPath) in cache: ", error.localizedDescription)
        }
    }

    /// Retrieve a Codable object from the cache, using the ``EndpointProtocol/keyPath`` identifier
    static func retrieveObject<T: Codable>(for endpoint: EndpointProtocol) -> T? {

        guard let endpointPath = endpoint.keyPath else { return nil }

        let filePath = documentsDirectory(with: endpointPath)

        guard let data = try? Data(contentsOf: filePath) else { return nil }

        do {
            let unarchiver = try NSKeyedUnarchiver (forReadingFrom: data)
            unarchiver.requiresSecureCoding = false
            let cachedObject = unarchiver.decodeDecodable(T.self, forKey: NSKeyedArchiveRootObjectKey)
            return cachedObject
        }
        catch let error {
            print("‼️ Failed to get object from cache: ", error.localizedDescription)
            return nil
        }
    }

    /// Private function used to create the file path
    static private func documentsDirectory(with filename: String) -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let directory = paths[0]

        return directory.appendingPathComponent(filename)
    }
}

// MARK: - DataFetcherProtocol
extension CacheManager: DataFetcherProtocol {

    func fetchData<T: Codable>(from endpoint: EndpointProtocol, as type: T.Type) async throws -> T {

        // #DevNote: With more time, I would have handle this error by fetching data from the NetworkManager
        guard let object: T = CacheManager.retrieveObject(for: endpoint)
        else {
            throw FetcherManager.FetchDataError.fetchCacheFailed
        }

        return object
    }
}
