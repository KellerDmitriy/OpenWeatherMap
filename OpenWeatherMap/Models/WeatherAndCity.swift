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
    let cityName: City
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

enum Link {
    case weatherURL
    case geoURL
    
    var url: URL {
        switch self {
        case .weatherURL:
            return URL(string: "https://api.openweathermap.org/data/2.5/weather?appid=c73e6f64b3e86d491e0ea199c3a89e47&units=metric&q=Mumbai")!
        case .geoURL:
            return URL(string: "https://secure.geonames.org/search?featureCode=PPLA&maxRows=10&username=dmitkeller")!
        }
    }
}



