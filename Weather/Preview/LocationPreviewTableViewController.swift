//
//  LocationPreviewTableViewController.swift
//  Weather
//
//  Created by Carlos Chaguendo on 16/03/22.
//

import UIKit
import PKHUD
import WeatherCore

class LocationPreviewTableViewController: UITableViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    private let location: Location
    private let formatter = MeasurementFormatter()
    private let dayNameFormatter = DateFormatter()
    
    private var weathers: [Weather] = []
    
    ///  Inicializa la previzualizacion del clima segun una ubicacion
    /// - Parameter location:
    init(location: Location) {
        self.location = location
        super.init(nibName: String(describing: LocationPreviewTableViewController.self), bundle: Bundle.main)
    }
    
    override func loadView() {
        super.loadView()
        dayNameFormatter.dateFormat = "EEEE"
        tableView.registerNIB(DayWeatherTableViewCell.self)
        tableView.separatorColor = .clear
        tableView.allowsSelection = false
    }
    
    @available(*, unavailable, message: "Cat not use inside storyboard")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDefaulValues()
        LocationService.getPlaceBy(id: location.woeid)
            .compactMap { $0 }
            .done(showPlaceInformation)
            .catch(showError)
    }
    
    /// Fija los valores por defecto de todos los componetes de vista
    private func setDefaulValues() {
        locationLabel.text = location.title
        temperatureLabel.text = ""
        statusLabel.text = dayNameFormatter.string(from: Date())
        imageView.image = UIImage()
        let temperature = Measurement(value: 0, unit: UnitTemperature.celsius)
        temperatureLabel.text = formatter.string(from: temperature)
    }
    
    private func showPlaceInformation(_ place: Place) {
        locationLabel.text = place.title
        weathers = place.weathers.sorted { $0.date < $1.date }
        guard let current = weathers.first else {
            preconditionFailure()
        }
        
        temperatureLabel.text = temperatureFormatt(current.temperature)
    
        let date = dayNameFormatter.string(from: Date())
        statusLabel.text = "\(date) - \(current.status.rawValue)"
        
        ImageService
            .getImageURL(status: current.statusCode)
            .compactMap{ UIImage(data: $0) }
            .done { img in
                self.imageView.animateUpdateImage(img)
            }.catch(self.showError)
                    
        tableView.reloadData()
    }
    
    /// Formatea un valor de una temperature a un valor reprecentable para el usuario
    /// - Parameters:
    ///   - temperature: El valor de la temperatura
    ///   - unit: La unidad de medida en la que esta el valor dado
    ///   - options:
    /// - Returns: la temperatura formatead segun la configuracion del lenguage & region del dipositivo
    private func temperatureFormatt(_ temperature: Double, unit: UnitTemperature = .celsius, options: MeasurementFormatter.UnitOptions = []) -> String {
        let ints = round(temperature)
        let temperature = Measurement(value: ints, unit: unit)
        formatter.unitOptions = options
        return formatter.string(from: temperature)
    }
    
    //MARK: - Table Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        weathers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeue(cell: DayWeatherTableViewCell.self, for: indexPath) else {
            preconditionFailure("Needs register cell before")
        }
        
        let weather = weathers[indexPath.row]
        cell.dayLabel.text = dayNameFormatter.string(from: weather.date)
        cell.statusLabel.text = weather.status.rawValue
        cell.minTemperatureLabel.text = temperatureFormatt(weather.minTemperature, options: .temperatureWithoutUnit)
        cell.maxTemperatureLabel.text = temperatureFormatt(weather.maxTemperature, options: .temperatureWithoutUnit)
        // TODO: Agregar la imagen que reresenta el estado del tiempo
        // hay que solucionar el problema con el resuso de las celdas y las promesas
        // cunado la promesa se cumpal, puede que la celda ya pertenesca a otro indice
        return cell
    }
}
