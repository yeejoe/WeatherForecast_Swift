//
//  ForecastWeatherModel.swift
//  weatherforecast
//
//  Created by Joe on 11/06/2020.
//  Copyright © 2020 Joe. All rights reserved.
//

import Foundation
import ObjectMapper

class ForecastWeatherModel : Mappable{
    var list : [WeatherModel] = []
    var cnt : Int = 0
    
    init() {
        
    }
    required init?(map: Map) {

    }

    // Mappable
    func mapping(map: Map) {
        list <- map["list"]
        cnt <- map["cnt"]
    }
}
