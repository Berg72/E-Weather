//
//  CityDetails.swift
//  E-Weather
//
//  Created by Mark bergeson on 11/13/21.
//

import Foundation

struct CityDetails: Codable {
    
    let consolidatedWeather: [ConsolidatedWeather]
    
    enum CodingKeys: String, CodingKey {
        case consolidatedWeather = "consolidated_weather"
        
    }
}

struct ConsolidatedWeather: Codable {
    
    let weatherStateName: String?
    let weatherStateAbbr: String?
    let applicableDate: String?
    let minTemp: Double?
    let maxTemp: Double?
    let theTemp: Double?
    
    enum CodingKeys: String, CodingKey {
        case weatherStateName = "weather_state_name"
        case weatherStateAbbr = "weather_state_abbr"
        case applicableDate = "applicable_date"
        case minTemp = "min_temp"
        case maxTemp = "max_temp"
        case theTemp = "the_temp"
    }
    
    func applicableDateString() -> String? {
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "yyyy-MM-dd"
        guard let date = formatter1.date(from: applicableDate ?? "") else {
            return nil
        }
        
        let formatter2 = DateFormatter()
        formatter2.dateFormat = "EEEE"
        return formatter2.string(from: date)
    }
    
}


            
