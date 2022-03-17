//
//  SearchLocationTableViewController.swift
//  Weather
//
//  Created by Carlos Chaguendo on 16/03/22.
//

import UIKit
import PromiseKit
import WeatherCore

/// Controlador encargado de gestionar la UI de busqueda de ubicaciones
class SearchLocationTableViewController: UITableViewController {
    
    private var locations:[Location] = []
    
    override func loadView() {
        super.loadView()
        navigationItem.title = "Locations"
        navigationItem.searchController = SearchController(delegate: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .always
        tableView.register(UITableViewCell.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        locations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeue(cell: UITableViewCell.self, for: indexPath) else {
            preconditionFailure("Needs register cell before")
        }
        let location = locations[indexPath.row]
        cell.textLabel?.text = location.title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let location = locations[indexPath.row]
        let ctrl = LocationPreviewTableViewController(location: location)
        self.show(ctrl, sender: nil)
    }
    
    
}

extension SearchLocationTableViewController: SearchControllerDelegate {
    
    func clearFilter(for vc: SearchController) {
        self.locations = []
        self.tableView.reloadData()
    }
    
    func searchController(_ vc: SearchController, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            return
        }
        firstly {
            LocationService.searchBy(name: searchText)
        }.done { results in
            self.locations = results
            self.tableView.reloadData()
            print("Results", results.count)
        }.catch { error in
            print("error", error)
            self.tableView.reloadData()
        }
    }
    
    
}