//
//  SearchLocationTableViewController.swift
//  Weather
//
//  Created by Carlos Chaguendo on 16/03/22.
//

import UIKit
import PromiseKit
import WeatherCore
import CoreLocation
import PMKCoreLocation

/// Controlador encargado de gestionar la UI de busqueda de ubicaciones
class SearchLocationTableViewController: UITableViewController {
    
    private let locationManager = CLLocationManager()
    private var locations:[Location] = []
    private var searchController: SearchController?
    
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var emptyButton: UIButton!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet var emptyView: UIView!
    
    init() {
        super.init(nibName: String(describing: SearchLocationTableViewController.self), bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        navigationItem.title = "Locations"
        tableView.backgroundView = backgroundView
        tableView.keyboardDismissMode = .interactive
        if #available(iOS 13, *) {
            navigationItem.searchController = SearchController(delegate: self)
            navigationItem.searchController?.searchBar.placeholder = "Search by city name"
        } else {
            let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 0, height: 44))
            searchBar.searchBarStyle = .prominent
            searchController = SearchController(delegate: self)
            tableView.tableHeaderView = searchBar
            searchBar.delegate = searchController
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .always
        tableView.register(UITableViewCell.self)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Near me", style: .done, target: self, action: #selector(searchByUserLocation))
        searchByUserLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesSearchBarWhenScrolling = false
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    @objc private func searchByUserLocation() {
        firstly {
            CLLocationManager.requestLocation(authorizationType: .whenInUse)
        }.firstValue
         .map { "\($0.coordinate.latitude),\($0.coordinate.longitude)"}
         .then { location in
            LocationService.searchBy(latlong: location)
         }.ensure {
             self.view.endEditing(true)
         }.done(on: DispatchQueue.main) { locations in
             self.locations = locations
             self.tableView.reloadData()
         }.catch { error in
             switch error {
             case CLLocationManager.PMKError.notAuthorized:
                 self.emptyButton.setTitle("Enable Location Services", for: .normal)
                 self.emptyButton.addTarget(self, action: #selector(self.openSettingsAction), for: .touchUpInside)
                 self.titleLabel.text = "Not Authorized"
                 self.messageLabel.text = "We use your location to display weather information for nearby locations"
                 self.tableView.backgroundView = self.emptyView
             default:
                 debugPrint(error)
             }
         }
    }
    
    @objc private func openSettingsAction() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        UIApplication.shared.open(url)
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
        self.view.endEditing(true)
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
