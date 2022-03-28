//
//  WeatherCityToday.swift
//  WeatherTest
//
//  Created by Polina on 26.03.2022.
//

import Foundation
import RealmSwift

@objcMembers class WeatherCityToday: Object {
    dynamic var name: String = ""
    dynamic var tempF: String = ""
    dynamic var tempC: String = ""
    dynamic var weatherDescription: String = ""
    dynamic var tempCMin: String = ""
    dynamic var tempCMax: String = ""
    dynamic var tempFMin: String = ""
    dynamic var tempFMax: String = ""
    
    convenience init(name: String, tempF: String, tempC: String, weatherDescription: String, tempCMin: String, tempCMax: String, tempFMin: String, tempFMax: String) {
        self.init()
        self.name = name
        self.tempF = tempF
        self.tempC = tempC
        self.weatherDescription = weatherDescription
        self.tempCMin = tempCMin
        self.tempCMax = tempCMax
        self.tempFMin = tempFMin
        self.tempFMax = tempFMax
    }
}

@objcMembers class WeatherCityFuture: Object {
    dynamic var tempCMin: String = ""
    dynamic var tempCMax: String = ""
    dynamic var tempFMin: String = ""
    dynamic var tempFMax: String = ""
    dynamic var icon: String = ""
    dynamic var dateString: String = ""
    
    convenience init(tempCMin: String, tempCMax: String, tempFMin: String, tempFMax: String, icon: String, dateString: String) {
        self.init()
        self.tempCMin = tempCMin
        self.tempCMax = tempCMax
        self.tempFMin = tempFMin
        self.tempFMax = tempFMax
        self.icon = icon
        self.dateString = dateString
    }
}


