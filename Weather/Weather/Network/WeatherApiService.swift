//
//  WeatherApiService.swift
//  Weather
//
//  Created by Sashen Pillay on 5/16/18.
//  Copyright © 2018 Sashen Pillay. All rights reserved.
//

import Foundation
import Alamofire


class WeatherApiService {
    
    func fetchWeather(_ latitude: String,_ longitude: String,_ completion: @escaping (Weather?, Error?) -> Void){
        let key = "65d6b740ce49a44b2ee0f67486702453"
        let longitude = longitude
        let latitude = latitude
        let jsonUrlString = "https://api.darksky.net/forecast/\(key)/\(latitude),\(longitude)?units=ca"
        Alamofire.request(jsonUrlString).responseJSON { (response) in
            if let error = response.error {
                completion(nil, error)
            } else {
                guard let weatherResponse = response.value as! [String: Any]?  else {
                    completion(nil, ConversionError.notConvertibleToDictionary)
                    return
                }
                var summary: String?
                var icon: String?
                var temperature: Double?
                let latitude = weatherResponse["latitude"] as? Double
                let longitude = weatherResponse["longitude"] as? Double
                let timeZone = weatherResponse["timezone"] as? String
                if let current = weatherResponse["currently"] as? [String: Any] {
                    summary = current["summary"] as? String
                    icon = current["icon"] as? String
                    temperature = current["temperature"] as? Double
                }
                let weather = Weather(timezone: timeZone!, summary: summary!, temperature: temperature!, icon: icon!, longitude: longitude!, latitude: latitude!)
                completion(weather, nil)
            }
        }
    }
}


enum ConversionError: Error {
    case notConvertibleToDictionary
}
