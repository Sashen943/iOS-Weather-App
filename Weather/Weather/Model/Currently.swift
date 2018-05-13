//
//  Currently.swift
//  Weather
//
//  Created by Sashen Pillay on 5/13/18.
//  Copyright © 2018 Sashen Pillay. All rights reserved.
//

import Foundation

class Currently : Decodable{
    var summary : String
    var icon : String
    var temperature : Double
    var apparentTemperature : Double
    var cloudCover : Double
    
    init( summary : String, icon : String, temperature : Double, apparentTemperature : Double,cloudCover : Double)
    {
        self.summary = summary
        self.icon = icon
        self.temperature = temperature
        self.apparentTemperature = apparentTemperature
        self.cloudCover = cloudCover
    }
}
