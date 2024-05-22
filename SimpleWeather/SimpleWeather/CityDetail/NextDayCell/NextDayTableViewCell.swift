//
//  NextDayTableViewCell.swift
//  SimpleWeather
//
//  Created by Maxime Lapointe on 2024-01-16.
//

import UIKit

class NextDayTableViewCell: UITableViewCell {

    @IBOutlet weak var dayNameLabel: UILabel!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var weatherIconImg: UIImageView!

    func configure(with forecast: Daily) {
        
        guard let temperature = forecast.temperature else { return }
        
        dayNameLabel.text = forecast.timestamp.timestampToWeekday
        minLabel.text = "\(temperature.tempMin.currentMetric)º"
        maxLabel.text = "\(temperature.tempMax.currentMetric)º"
        weatherIconImg.image = forecast.weather?.first?.iconForWeather
    }
}
