//
//  WeatherDisplayViewController.swift
//  Weather
//
//  Created by Sashen Pillay on 5/13/18.
//  Copyright © 2018 Sashen Pillay. All rights reserved.
//

import UIKit
import MapKit
import Alamofire

class WeatherDisplayViewController: UIViewController, CLLocationManagerDelegate  {
    
    @IBOutlet weak var tempreture: UILabel!
    @IBOutlet weak var feel: UILabel!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var weathericon: UIImageView!
    var locationManager = CLLocationManager()
    var weather = [Weather]()
    
    public struct Weather : Decodable{
        public var latitude : Double
        public var longitude : Double
        public var timezone : String
        public var currently : Currently
    }
    
    public struct Currently : Decodable{
        public var summary : String
        public var icon : String
        public var temperature : Double
        public var apparentTemperature : Double
        public var cloudCover : Double
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locationValue:CLLocationCoordinate2D = manager.location!.coordinate
        let weatherApiService = WeatherApiService()
        weatherApiService.fetchWeather(locationValue.latitude.description, locationValue.longitude.description) { (weather, error) in
            if let weather = weather {
                self.tempreture.text = "\(weather.temperature)°C"
                self.feel.text = "Feels like  \(weather.temperature)°C"
                self.summary.text = weather.summary
                self.location.text = weather.timezone
                let image = UIImage(named: "clear-day")
                self.weathericon.image = image
            }
        }
    }
    
}
