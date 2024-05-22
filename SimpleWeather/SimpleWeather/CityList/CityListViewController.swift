//
//  CityListViewController.swift
//  SimpleWeather
//
//  Created by Maxime Lapointe on 2024-01-15.
//

import UIKit

class CityListViewController: UITableViewController {
        
    private let viewModel = CityListViewModel()
    private let cityCellId = "CityTableViewCellId"

    private let searchController = UISearchController(searchResultsController: nil)

    // Computed Properties
    private var activeList: [CityWeather] {
        return isFiltering ? filteredCities : viewModel.citiesWeather
    }
    private var filteredCities: [CityWeather] {
        guard let searchText = searchBarText else { return [] }
        return viewModel.citiesWeather.filter {
            guard let city = $0.city else { return false }
            return city.name.lowercased().contains(searchText.lowercased())
        }
    }
    private var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    private var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    private var searchBarText: String? {
        return searchController.searchBar.text
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Cities"
        
        viewModel.delegate = self
        Task { await viewModel.loadDisplayData() }

        tableView.register(UINib(nibName: "CityTableViewCell", bundle: nil), 
                           forCellReuseIdentifier: cityCellId)

        setupNavigationBarItem()
        setupSearchBar()
    }

    // MARK: - Setup UI
    func setupNavigationBarItem() {

        let buttonTitle = UserDefaults.isCelcius ? "ºF" : "ºC"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: buttonTitle,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(didSelectMetricButton))
    }

    private func setupSearchBar() {

        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        //searchController.searchBar.placeholder = Strings.common.searchPlaceholder
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }

    // Actions
    @objc func didSelectMetricButton() {
        UserDefaults.isCelcius = !UserDefaults.isCelcius

        setupNavigationBarItem()
        tableView.reloadData()
    }

    // MARK: - Table view delegates
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activeList.count
        //viewModel.citiesWeather.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //let cityWeather = viewModel.citiesWeather[indexPath.row]
        let cityWeather = activeList[indexPath.row]

        if let cell = tableView.dequeueReusableCell(withIdentifier: cityCellId, for: indexPath) as? CityTableViewCell {
            cell.configure(with: cityWeather)
            return cell
        }

        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //let selectedCity = viewModel.citiesWeather[indexPath.row]
        let selectedCity = activeList[indexPath.row]

        let cityDetailVC = CityDetailViewController()
        cityDetailVC.setupViewModel(with: selectedCity)
        
        navigationController?.pushViewController(cityDetailVC, animated: true)
    }
}

// MARK: - CityListViewModelDelegate Delegate
extension CityListViewController: CityListViewModelDelegate {
    
    func didFetched() {
        tableView.reloadData()
    }
    
    func failedToFetchData() {
        
        let alert = UIAlertController(title: "Error",
                                      message: "An error occurred",
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
}

// MARK: - UISearchBar Delegate
extension CityListViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        tableView.reloadData()
    }
}
