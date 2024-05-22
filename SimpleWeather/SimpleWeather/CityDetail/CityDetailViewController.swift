//
//  CityDetailViewController.swift
//  SimpleWeather
//
//  Created by Maxime Lapointe on 2024-01-16.
//

import UIKit

class CityDetailViewController: UIViewController {
    
    private var viewModel: CityDetailViewModel?
    private let nextDayCellId = "NextDayTableViewCellId"

    // Outlets
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var weatherIconImg: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var minMaxLabel: UILabel!
    @IBOutlet weak var nextDaysTableView: UITableView!

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel?.cityWeather.city?.name
        
        setupCurrentWeatherSection()
        setupTableView()
    }
    
    // MARK: - Setup UI
    func setupViewModel(with cityWeather: CityWeather) {
        viewModel = CityDetailViewModel(cityWeather: cityWeather)
    }
    
    func setupCurrentWeatherSection() {
        
        guard let currentTemp = viewModel?.cityWeather.current?.temp,
              let todayTemp = viewModel?.cityWeather.daily?.first?.temperature,
              let todayWeather = viewModel?.cityWeather.daily?.first?.weather?.first
        else { return }
        
        currentTempLabel.text = "\(currentTemp.currentMetric)º"
        minMaxLabel.text = "min: \(todayTemp.tempMin.currentMetric)º • max: \(todayTemp.tempMax.currentMetric)º"

        weatherIconImg.image = todayWeather.iconForWeather
        descriptionLabel.text = todayWeather.description.capitalized
    }
    
    func setupTableView() {
        nextDaysTableView.dataSource = self
        nextDaysTableView.delegate = self
        
        nextDaysTableView.register(UINib(nibName: "NextDayTableViewCell", bundle: nil),
                                   forCellReuseIdentifier: nextDayCellId)
        
        // Adding bottom inset so the home bar doesn't overlap teh tableview
        nextDaysTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20.0, right: 0)
    }
}

// MARK: - UITableView Delegates
extension CityDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let nextDays = viewModel?.nextDaysForecast else { return 0 }
        return nextDays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let forecast = viewModel?.nextDaysForecast?[indexPath.row] else { return UITableViewCell() }

        if let cell = tableView.dequeueReusableCell(withIdentifier: nextDayCellId, for: indexPath) as? NextDayTableViewCell {
            cell.configure(with: forecast)
            return cell
        }

        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
}
