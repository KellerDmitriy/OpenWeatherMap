//
//  WeatherAndCity.swift
//  OpenWeatherMap
//
//  Created by Келлер Дмитрий on 14.05.2023.
//

import Foundation

struct Cities: Decodable {
    let totalResultsCount: [City]
}

struct City: Decodable {
    let geonameId: Int
    let name: String
    let countryName: String
    
    var cityAndCountry: String {
        return "\(name) (\(countryName))"
    }
 
}

struct Weather: Decodable {
    let conditionalId: Int
    let cityName: String
    let temperature: Double
    let precipitation: Double
    let windSpeed: Double
    
    var description: String {
            """
            Name: \(cityName)
            Temperature: \(temperature)
            Precipitation: \(precipitation)
            WindSpeed: \(windSpeed)
            """
    }
    
    init(from weatherData:[String: Any]) {
            conditionalId = weatherData["conditionalId"] as? Int ?? 0
            cityName = weatherData["cityName"] as? String ?? ""
            temperature = weatherData["temperature"] as? Double ?? 0.0
            precipitation = weatherData["precipitation"] as? Double ?? 0.0
            windSpeed = weatherData["windSpeed"] as? Double ?? 0.0
    }


var conditionalName: String {
    switch conditionalId {
    case 200...232:
        return "cloud.bolt"
    case 300...321:
        return "cloud.drizzle"
    case 500...531:
        return "cloud.rain"
    case 600...622:
        return "cloud.snow"
    case 701...781:
        return "cloud.fog"
    case 800:
        return "sun.max"
    case 801...804:
        return "cloud.bolt"
    default:
        return "cloud"
    }
}
var formattedTemperature: String {
    return String(format: "%.1f°", temperature)
}

   

}




