//
//  WeatherProvider.swift
//  weatherforecast
//
//  Created by Joe on 11/06/2020.
//  Copyright © 2020 Joe. All rights reserved.
//

import Foundation
import Alamofire

class WeatherProvider{
    static let apiKey = "e86bf40087be1e52116c2c02d70f702e"
    static func fetchWeather(location : String) -> WeatherModel{
        AF.request(WEATHER_API_URL+"data/2.5/weather?q="+location+"&APPID="+apiKey)
        return WeatherModel()
    }
}
