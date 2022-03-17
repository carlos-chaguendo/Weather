//
//  Weather.swift
//  
//
//  Created by Carlos Chaguendo on 16/03/22.
//

import Foundation

extension Weather {

    public enum Status: String, Codable {
        case snow = "Snow"
        case hail = "Hail"
        case sleet = "Sleet"
        case thunderstorm = "Thunderstorm"
        case heavyRain = "Heavy Rain"
        case lightRain = "Light Rain"
        case showers = "Showers"
        case heavyCloud = "Heavy Cloud"
        case lightCloud = "Light Cloud"
        case celar = "Clear"
        case thunder = "Thunder"
    }

}
