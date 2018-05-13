//
//  WeatherDisplayViewController.swift
//  Weather
//
//  Created by Sashen Pillay on 5/13/18.
//  Copyright © 2018 Sashen Pillay. All rights reserved.
//

import UIKit
import MapKit

class WeatherDisplayViewController: UIViewController, CLLocationManagerDelegate  {
    
    @IBOutlet weak var tempreture: UILabel!
    @IBOutlet weak var feel: UILabel!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var location: UILabel!
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
        // Dispose of any resources that can be recreated.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locationValue:CLLocationCoordinate2D = manager.location!.coordinate
        parseJSON(longitude:locationValue.longitude.description, latitude:locationValue.latitude.description )
        populateUI()
    }
    
    func  parseJSON(longitude : String , latitude :String) {
        let key = "65d6b740ce49a44b2ee0f67486702453"
        let longitude = longitude
        let latitude = latitude
        let jsonUrlString = "https://api.darksky.net/forecast/\(key)/\(latitude),\(longitude)?units=ca"
        
        guard let url = URL(string: jsonUrlString) else{
            print("Error : cannot create URL string")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {
                print("Error : cannot fetch data")
                return
            }
            
            do{
                let object =  try JSONDecoder().decode(Weather.self, from: data)
                self.weather.append(object)
            } catch let jsonErr{
                print("Error : could not serialize data", jsonErr)
            }
            }.resume()
    }
    
    func populateUI(){
        for item in weather {
            print(item)
            self.tempreture.text = item.currently.temperature.description
            self.feel.text = item.currently.apparentTemperature.description
            self.summary.text = item.currently.summary
            self.location.text = item.timezone
        }
        
        
    }
}
