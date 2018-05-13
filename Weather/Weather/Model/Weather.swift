//
//  Weather.swift
//  Weather
//
//  Created by Sashen Pillay on 5/13/18.
//  Copyright © 2018 Sashen Pillay. All rights reserved.
//

import Foundation

class Weather{
    
    var latitude : Double
    var longitude : Double
    var timezone : String
    var currently : Currently
    
    init(latitude : Double, longitude : Double, timezone : String,currently : Currently){
        self.latitude = latitude
        self.longitude = longitude
        self.timezone = timezone
        self.currently = currently
    }
}
