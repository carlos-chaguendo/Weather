//
//  LocationService.swift
//  
//
//  Created by Carlos Chaguendo on 16/03/22.
//

import PromiseKit

public enum LocationService {

    /// Busca ubicaciones que coincida con el nombre
    /// - Parameter name: Nombre  a buscar
    /// - Returns:  Promesa con `Array` de ubicaiones
    public static func searchBy(name: String) -> Promise<[Location]> {
        Http.request(.get, "/location/search", parameters: ["query": name])
    }

    ///  Busca ubicaciones cercanas segun las cordenadas dadas
    /// - Parameter latlong: Coordenadas para buscar lugares cercanos.
    /// - Returns: Promesa con `Array` de ubicaiones
    public static func searchBy(latlong: String) -> Promise<[Location]> {
        Http.request(.get, "/location/search", parameters: ["lattlong": latlong])
    }

    /// Obtiene la informacion del clima, segun un idntificador de un lugar en el mundo
    /// - Parameter id: identificador `Where On Earth ID`
    /// - Returns: Promesa con la informacion del clima de un lugar
    public static func getPlaceBy(id: Int) -> Promise<Place?> {
        Http.request(.get, "/location/\(id)")
    }

}
