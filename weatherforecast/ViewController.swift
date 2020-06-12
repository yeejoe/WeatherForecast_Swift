//
//  ViewController.swift
//  weatherforecast
//
//  Created by Joe on 11/06/2020.
//  Copyright © 2020 Joe. All rights reserved.
//

import UIKit
import FSPagerView
import CoreLocation
import Alamofire
import Kingfisher


protocol DrawerLocationDelegate{
    func onSelectedLocation(locationName : String)
}

class ViewController: UIViewController, FSPagerViewDataSource, DrawerLocationDelegate {
    @IBOutlet var outerCircle: UIView!
    @IBOutlet var innerCircle: UIView!
    @IBOutlet var pagerView: FSPagerView!{
        didSet {
            self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        }
    }
    
    @IBOutlet var topTemp: UILabel!
    @IBOutlet var topFeelLike: UILabel!
    
    @IBOutlet var leftMinTemp: UILabel!
    @IBOutlet var leftHumidity: UILabel!
    
    @IBOutlet var rightMaxTemp: UILabel!
    @IBOutlet var rightPressure: UILabel!
    
    @IBOutlet var bottomCloud: UILabel!
    @IBOutlet var bottomWind: UILabel!
    @IBOutlet var bottomDate: UILabel!
    @IBOutlet var bottomTime: UILabel!
    
    @IBOutlet var centerCloudImage: UIImageView!
    var weatherList = [WeatherModel]()
    var weatherForecastList = ForecastWeatherModel()
    var locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        outerCircle.layer.cornerRadius = outerCircle.frame.size.width / 2
        
        innerCircle.layer.cornerRadius = innerCircle.frame.size.width / 2
        innerCircle.layer.borderWidth = 1
        innerCircle.layer.borderColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 12).cgColor
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let selectedLocation = LocationProvider.getUserSelectedLocationName()
        self.title = selectedLocation
        
        let parameters = ["q": selectedLocation, "APPID": API_KEY]
        AF.request(WEATHER_API_URL+"data/2.5/weather", parameters: parameters ).responseJSON { (response) in
            switch(response.result){
            case .success(let jsonResponse):
                if let json = jsonResponse as? [String:Any]{
                    let model = WeatherModel(JSON: json)
                    
                    self.topTemp.text = String.init(format: "%.1f", (model?.main.temp ?? 0.0) - 273.15)
                    self.topFeelLike.text = String.init(format: "Feels Like %.1f", model?.main.feels_like ?? 0.0)
                    
                    self.leftMinTemp.text = String.init(format: "Min %.1f°C", (model?.main.temp_min ?? 0.0) - 273.15)
                    self.leftHumidity.text = String.init(format: "%d%%", model?.main.humidity ?? 0.0)
                    
                    self.rightMaxTemp.text = String.init(format: "Max %.1f°C", (model?.main.temp_max ?? 0.0) - 273.15)
                    self.rightPressure.text = String.init(format: "%d hPa", model?.main.pressure ?? 0)
                    
                    self.bottomCloud.text = model?.weather[0].main
                    self.bottomWind.text = String.init(format: "Wind %.1f m/s", model?.wind.speed ?? 0.0)
                    let df = DateFormatter()
                    df.dateFormat = "MMM dd"
                    let df2 = DateFormatter()
                    df2.dateFormat = "h:mm a"
                    self.bottomDate.text = df.string(from: Date())
                    self.bottomTime.text = df2.string(from: Date())
                    let url = URL(string: WEATHER_ICON_URL+(model?.weather[0].icon ?? "")+"@2x.png")
                    self.centerCloudImage.kf.setImage(with: url)
                }
            case .failure(let err):
                print("err:\(err)")
            }
        }
    }

    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return weatherForecastList.list.count
    }
        
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.textLabel?.text = "Testing"
        return cell
    }
    @IBAction func selectLocationPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "drawer", sender: self)
    }
    @IBAction func getCurrentLocationPressed(_ sender: Any) {
        locationManager.requestWhenInUseAuthorization()
        var currentLoc: CLLocation!
        if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
        CLLocationManager.authorizationStatus() == .authorizedAlways) {
           currentLoc = locationManager.location
            let parameters = ["lat": currentLoc.coordinate.latitude, "APPID": API_KEY, "lon": currentLoc.coordinate.longitude] as [String : Any]
            AF.request(WEATHER_API_URL+"data/2.5/weather", parameters: parameters ).responseJSON { (response) in
                switch(response.result){
                case .success(let jsonResponse):
                    if let json = jsonResponse as? [String:Any]{
                        let model = WeatherModel(JSON: json)
                        
                        self.topTemp.text = String.init(format: "%.1f", (model?.main.temp ?? 0.0) - 273.15)
                        self.topFeelLike.text = String.init(format: "Feels Like %.1f", model?.main.feels_like ?? 0.0)
                        
                        self.leftMinTemp.text = String.init(format: "Min %.1f°C", (model?.main.temp_min ?? 0.0) - 273.15)
                        self.leftHumidity.text = String.init(format: "%d%%", model?.main.humidity ?? 0.0)
                        
                        self.rightMaxTemp.text = String.init(format: "Max %.1f°C", (model?.main.temp_max ?? 0.0) - 273.15)
                        self.rightPressure.text = String.init(format: "%d hPa", model?.main.pressure ?? 0)
                        
                        self.bottomCloud.text = model?.weather[0].main
                        self.bottomWind.text = String.init(format: "Wind %.1f m/s", model?.wind.speed ?? 0.0)
                        let df = DateFormatter()
                        df.dateFormat = "MMM dd"
                        let df2 = DateFormatter()
                        df2.dateFormat = "h:mm a"
                        self.bottomDate.text = df.string(from: Date())
                        self.bottomTime.text = df2.string(from: Date())
                        let url = URL(string: WEATHER_ICON_URL+(model?.weather[0].icon ?? "")+"@2x.png")
                        self.centerCloudImage.kf.setImage(with: url)
                        self.title = "My Location"
                    }
                case .failure(let err):
                    print("err:\(err)")
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let drawerController = segue.destination as? DrawerLocationController{
            drawerController.drawerDelegate = self
        }
    }
    func onSelectedLocation(locationName: String) {
        
    }
}

