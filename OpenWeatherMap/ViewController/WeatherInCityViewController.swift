//
//  WeatherInCityViewController.swift
//  OpenWeatherMap
//
//  Created by Келлер Дмитрий on 14.05.2023.
//

import UIKit

final class WeatherInCityViewController: UITableViewController {
    
    //MARK: Private properties
    private let networkManager = NetworkManager.shared
    
    private var weatherInCity: Weather?
    private var cities: Cities? = nil
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var filteredCity: [City] = []
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        setupNavigationBar()
        networkManager.fetchWeather()
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let city = isFiltering
        ? filteredCity[indexPath.row]
        : cities?.totalResultsCount[indexPath.row]
        guard let detailVC = segue.destination as? WeatherDetailsViewController else { return }
        detailVC.city = city
    }
    
    // MARK: - Private methods
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.barTintColor = .darkGray
        navigationItem.searchController = searchController
        definesPresentationContext = true
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.font = UIFont.boldSystemFont(ofSize: 17)
            textField.textColor = .darkGray
        }
    }
    
    private func setupNavigationBar() {
        title = "Weather in the city"
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = .white
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]

        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
    private func fetchWeather() {
        networkManager.fetchCity(from: Link.geoURL.url) { [weak self] result in
            switch result {
            case .success(let weather):
                self?.cities = city
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

    // MARK: - UITableViewDataSource
    extension WeatherInCityViewController {
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cities?.totalResultsCount.count ?? 20
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let city = isFiltering
        ? filteredCity[indexPath.row]
        : cities?.totalResultsCount[indexPath.row]
        
        content.text = city?.cityAndCountry
        cell.contentConfiguration = content
        return cell
    }
}

extension WeatherInCityViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text ?? "")
    }
    func filterContentForSearchText(_ searchText: String) {
        filteredCity = cities?.totalResultsCount.filter { city in
            city.cityAndCountry.lowercased().contains(searchText.lowercased())
        } ?? []
        tableView.reloadData()
    }
}
