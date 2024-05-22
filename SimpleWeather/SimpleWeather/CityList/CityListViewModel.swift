//
//  CityListViewModel.swift
//  SimpleWeather
//
//  Created by Maxime Lapointe on 2024-01-15.
//

import Foundation

protocol CityListViewModelDelegate: AnyObject {
    @MainActor func didFetched()
    @MainActor func failedToFetchData()
}

class CityListViewModel {
    
    weak var delegate: CityListViewModelDelegate?
    var citiesWeather = [CityWeather]()
    
    func loadDisplayData() async {
        
        await fetchCities()
        await delegate?.didFetched()
    }
    
    func fetchCities() async {
        
        var weathers = [CityWeather]()

        // Fetcher depending if we take the date from the cache or online
        let dataFetcher: any DataFetcherProtocol = FetcherManager.getDataFetcher()

        for city in CityData.cities {

            do {
                let endpoint = CityWeatherEndpoint(city: city)
                var cityWeather: CityWeather = try await dataFetcher.fetchData(from: endpoint, as: CityWeather.self)

                cityWeather.city = city
                weathers.append(cityWeather)
            } catch(let error) {
                await delegate?.failedToFetchData()
                return
            }
        }
        
        citiesWeather = weathers.sorted(by: { $0.city?.name ?? "" < $1.city?.name ?? "" })
    }
}
