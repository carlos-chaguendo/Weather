//
//  Place.swift
//  
//
//  Created by Carlos Chaguendo on 16/03/22.
//

import Foundation

public class Place: Codable {
    public let timezoneId: String
    public let title: String
    public let woeid: Int
    public let weathers: [Weather]

    enum CodingKeys: String, CodingKey {
         case title
         case timezoneId = "timezone"
         case woeid
         case weathers = "consolidated_weather"
     }

    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decode(String.self, forKey: .title)
        timezoneId = try values.decode(String.self, forKey: .timezoneId)
        woeid = try values.decode(Int.self, forKey: .woeid)
        weathers = try values.decode([Weather].self, forKey: .weathers)
    }
}
