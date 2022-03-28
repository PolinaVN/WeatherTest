//
//  CitySourse.swift
//  WeatherTest
//
//  Created by Polina on 27.03.2022.
//

import Foundation

final class CitySourse {
    var name: String
    var lon: Double
    var lat: Double
    var isSelected: Bool
    
    init(name: String, lon: Double, lat: Double, isSelected: Bool) {
        self.name = name
        self.lon = lon
        self.lat = lat
        self.isSelected = isSelected
    }
}
