//
//  LocationService.swift
//  
//
//  Created by Carlos Chaguendo on 16/03/22.
//

import PromiseKit

public enum LocationService {
    
    public static func searchBy(name: String) -> Promise<[Location]> {
        Http.request(.get, "/location/search", parameters: ["query": name])
    }
}
