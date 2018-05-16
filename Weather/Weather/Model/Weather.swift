//
//  Weather.swift
//  Weather
//
//  Created by Sashen Pillay on 5/13/18.
//  Copyright © 2018 Sashen Pillay. All rights reserved.
//

import Foundation
import Alamofire

struct Weather {

    let timezone : String
    let summary : String
    let temperature : Int
    let icon : String
    let longitude : Double
    let latitude : Double
   
    init(timezone : String, summary : String, temperature : Double , icon : String, longitude : Double, latitude : Double) {
        self.timezone = timezone
        self.temperature = Int(temperature)
        self.icon = "\(icon).jpg"
        self.longitude = longitude
        self.latitude = latitude
        self.summary = summary
    }
}
