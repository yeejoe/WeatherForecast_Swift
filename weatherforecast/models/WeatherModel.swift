//
//  WeatherModel.swift
//  weatherforecast
//
//  Created by Joe on 11/06/2020.
//  Copyright © 2020 Joe. All rights reserved.
//

import Foundation
import ObjectMapper

class WeatherModel : Mappable{
    var weather : [Weather] = []
    var main = Main()
    var cloud = Cloud()
    var wind = Wind()
    var base = ""
    var dt = 0
    var name = ""
    
    init() {
        
    }
    required init?(map: Map) {

    }

    // Mappable
    func mapping(map: Map) {
        weather <- map["weather"]
        main <- map["main"]
        cloud <- map["cloud"]
        wind <- map["wind"]
        base <- map["base"]
        dt <- map["dt"]
        name <- map["name"]
    }
}

class Weather : Mappable{
    var main = ""
    var description = ""
    var icon = ""
    init() {
        
    }
    required init?(map: Map) {

    }

    // Mappable
    func mapping(map: Map) {
        main <- map["main"]
        description <- map["description"]
        icon <- map["icon"]
    }
}

class Main : Mappable{
    var temp = 0.0
    var feels_like = 0.0
    var temp_min = 0.0
    var temp_max = 0.0
    var pressure = 0
    var humidity = 0
    init() {
        
    }
    required init?(map: Map) {

    }

    // Mappable
    func mapping(map: Map) {
        temp <- map["temp"]
        feels_like <- map["feels_like"]
        temp_min <- map["temp_min"]
        temp_max <- map["temp_max"]
        humidity <- map["humidity"]
        pressure <- map["pressure"]
    }
}

class Wind : Mappable{
    var speed = 0.0
    
    init() {
        
    }
    required init?(map: Map) {

    }

    // Mappable
    func mapping(map: Map) {
        speed <- map["speed"]
    }
}

class Cloud : Mappable{
    var all = 0
    init() {
        
    }
    required init?(map: Map) {

    }

    // Mappable
    func mapping(map: Map) {
        all <- map["all"]
    }
}

