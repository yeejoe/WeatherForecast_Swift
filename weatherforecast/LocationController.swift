//
//  LocationController.swift
//  weatherforecast
//
//  Created by Joe on 11/06/2020.
//  Copyright © 2020 Joe. All rights reserved.
//

import UIKit
import ObjectMapper
class LocationController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var mainTableView: UITableView!
    var locationList = [LocationModel]()
    var drawerLocationList = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Edit Location"
        if let path = Bundle.main.path(forResource: "locations", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                locationList = try Mapper<LocationModel>().mapArray(JSONString: String.init(data: data, encoding: .utf8) ?? "[]")
                
                
              } catch(let e) {
                   // handle error
                print("error:\(e)")
              }
        }
        drawerLocationList = LocationProvider.getUserDrawerLocations()
        // Do any additional setup after loading the view.
        mainTableView.register(UINib.init(nibName: "LocationCell", bundle: nil), forCellReuseIdentifier: "normal")
        mainTableView.delegate = self
        mainTableView.dataSource = self
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "normal") as! LocationCell
        let cellData = locationList[indexPath.row]
        cell.locationName.text = cellData.city
        cell.accessoryType = drawerLocationList.contains(cellData.city) ? .checkmark : .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellData = locationList[indexPath.row]
        drawerLocationList = LocationProvider.toggleUserDrawerLocation(locationName: cellData.city)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

}
