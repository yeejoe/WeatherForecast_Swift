//
//  DrawerLocationController.swift
//  weatherforecast
//
//  Created by Joe on 11/06/2020.
//  Copyright © 2020 Joe. All rights reserved.
//

import UIKit

class DrawerLocationController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var mainTableView: UITableView!
    var selectedLocationName = "Kuala Lumpur"
    var drawerLocationList = [String]()
    var drawerDelegate : DrawerLocationDelegate? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Locations"
        selectedLocationName = LocationProvider.getUserSelectedLocationName()
        drawerLocationList = LocationProvider.getUserDrawerLocations()
        // Do any additional setup after loading the view.
        mainTableView.register(UINib.init(nibName: "LocationCell", bundle: nil), forCellReuseIdentifier: "normal")
        mainTableView.delegate = self
        mainTableView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        drawerLocationList = LocationProvider.getUserDrawerLocations()
        mainTableView.reloadData()
    }
    
    @IBAction func editLocationPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "edit", sender: self)
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drawerLocationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "normal") as! LocationCell
        let cellData = drawerLocationList[indexPath.row]
        cell.locationName.text = cellData
        cell.accessoryType = selectedLocationName == cellData ? .checkmark : .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellData = drawerLocationList[indexPath.row]
        LocationProvider.setUserSelectedLocationName(locationName: cellData)
        self.navigationController?.popViewController(animated: true)
        if let dd = drawerDelegate{
            dd.onSelectedLocation(locationName: cellData)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

}
