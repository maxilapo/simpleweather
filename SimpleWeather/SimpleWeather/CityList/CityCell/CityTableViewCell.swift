//
//  CityTableViewCell.swift
//  SimpleWeather
//
//  Created by Maxime Lapointe on 2024-01-15.
//

import UIKit

class CityTableViewCell: UITableViewCell {

    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var tempMinLabel: UILabel!
    @IBOutlet weak var tempMaxLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var weatherIconImg: UIImageView!

    func configure(with cityWeather: CityWeather) {
        
        guard let city = cityWeather.city,
              let currentTemp = cityWeather.current?.temp,
              let todayTemp = cityWeather.daily?.first?.temperature,
              let todayWeather = cityWeather.daily?.first?.weather?.first
        else { return }
        
        cityNameLabel.text = city.name
        tempMinLabel.text = "min: \(todayTemp.tempMin.currentMetric)º"
        tempMaxLabel.text = "max: \(todayTemp.tempMax.currentMetric)º"
        currentTempLabel.text = "\(currentTemp.currentMetric)º"
        
        descriptionLabel.text = todayWeather.description.capitalized
        weatherIconImg.image = todayWeather.iconForWeather
    }
}
