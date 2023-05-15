//
//  WeatherDetailsViewController.swift
//  OpenWeatherMap
//
//  Created by Келлер Дмитрий on 14.05.2023.
//

import UIKit

final class WeatherDetailsViewController: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    
    var city: City!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionLabel.text = city.cityAndCountry
      
    }

}

