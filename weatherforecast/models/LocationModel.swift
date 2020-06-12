//
//  File.swift
//  weatherforecast
//
//  Created by Joe on 11/06/2020.
//  Copyright © 2020 Joe. All rights reserved.
//

import Foundation
import ObjectMapper

class LocationModel : ImmutableMappable{
    let city : String
    let lat : Double
    let lng : Double
    
    required init(map: Map) throws {
        let transform = TransformOf<Double, String>(fromJSON: { (value: String?) -> Double? in
            // transform value from String? to Int?
            if let s = value{

                return Double(s)
            }else{
                return 0.0
            }
        }, toJSON: { (value: Double?) -> String? in
            // transform value from Int? to String?
            if let value = value {
                return String(value)
            }
            return nil
        })
        city = try map.value("city")
        lat = try map.value("lat", using: transform)
        lng = try map.value("lng", using: transform)
        
    }

    // Mappable
    func mapping(map: Map) {
        city >>> map["city"]
        lat >>> map["lat"]
        lng >>> map["lng"]
    }
}
