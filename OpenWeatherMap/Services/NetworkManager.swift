//
//  NetworkManager.swift
//  OpenWeatherMap
//
//  Created by Келлер Дмитрий on 14.05.2023.
//

import Foundation
import Alamofire


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

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchCity(from url: URL, completion: @escaping(Result<[City], AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let data):
                    let cities = 
                    completion(.success(data))
                case .failure(let error):
                    print(error)
                }
            }
    }
    

}
