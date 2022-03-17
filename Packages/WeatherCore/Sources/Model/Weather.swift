//
//  Weather.swift
//  
//
//  Created by Carlos Chaguendo on 16/03/22.
//

import Foundation

public class Weather: Codable {
    public let id: Int64
    public let minTemperature: Double
    public let maxTemperature: Double
    public let temperature: Double
    public let status: Status
    public let statusCode: String
    public let date: Date

    enum CodingKeys: String, CodingKey {
        case id
        case minTemperature = "min_temp"
        case maxTemperature = "max_temp"
        case temperature = "the_temp"
        case status = "weather_state_name"
        case date = "applicable_date"
        case statusCode = "weather_state_abbr"
    }

    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        id = try values.decode(Int64.self, forKey: .id)
        minTemperature = try values.decode(Double.self, forKey: .minTemperature)
        maxTemperature = try values.decode(Double.self, forKey: .maxTemperature)
        temperature = try values.decode(Double.self, forKey: .temperature)
        status = try values.decode(Weather.Status.self, forKey: .status)
        statusCode = try values.decode(String.self, forKey: .statusCode)
        let date  = try values.decode(String.self, forKey: .date)

        guard let date = DateFormatter.yyyyMMdd.date(from: date) else {
            preconditionFailure("Invalid date formatt")
        }
        self.date = date
    }
}
