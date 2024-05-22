//
//  FetchDataManager.swift
//  SimpleWeather
//
//  Created by Maxime Lapointe on 2024-01-16.
//

import Foundation

final class FetcherManager {

    enum FetchDataError: Error {
        case fetchCacheFailed
    }

    /// Return the proper Fetcher base on the Cache expiry
    /// If the cache is expired, return the Network Fetcher
    static func getDataFetcher() -> DataFetcherProtocol {

        if let lastFetchDate = UserDefaults.lastOnlineFetch, lastFetchDate.isLessThanCacheExpiry() {
            return CacheManager()
        } else {
            return NetworkManager()
        }
    }
}
