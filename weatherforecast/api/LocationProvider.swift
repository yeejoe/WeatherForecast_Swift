//
//  LocationProvider.swift
//  weatherforecast
//
//  Created by Joe on 11/06/2020.
//  Copyright © 2020 Joe. All rights reserved.
//

import Foundation

class LocationProvider{
    
    private static func getDefaultSelectedLocation() -> String{
        return "Kuala Lumpur"
    }
    private static func getDefaultLocations() -> [String]{
        return ["Kuala Lumpur", "Johor Bahru", "George Town"]
    }
    static func setUserSelectedLocationName(locationName : String){
        UserDefaults.standard.set(locationName, forKey: SELECTED_LOCATION_KEY)
    }
    static func toggleUserDrawerLocation(locationName : String) -> [String]{
        let defaultLoc = getDefaultLocations()
        var curLocations = getUserDrawerLocations()
        
        if !defaultLoc.contains(locationName){
            let position = curLocations.firstIndex(of: locationName)
            if let p = position{
                curLocations.remove(at: p)
            }else{
                curLocations.append(locationName)
            }
        }
        UserDefaults.standard.set(curLocations, forKey: AVAILABLE_SELECTION_LOCATION_KEY)
        return curLocations
    }
    static func getUserSelectedLocationName() -> String{
        let selectedLocationName = UserDefaults.standard.value(forKey: SELECTED_LOCATION_KEY) as? String
        return selectedLocationName ?? getDefaultSelectedLocation()
    }
    static func getUserDrawerLocations() -> [String]{
        var resultLocations = [String]()
        let asLocations = UserDefaults.standard.stringArray(forKey: AVAILABLE_SELECTION_LOCATION_KEY) ?? []
        let defaultAsLocations = getDefaultLocations()
        resultLocations.append(contentsOf: defaultAsLocations)
        resultLocations.append(contentsOf: asLocations)
        resultLocations = Array(Set(resultLocations))
        return resultLocations
    }
}
