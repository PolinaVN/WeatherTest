//
//  WeatherDataResponse.swift
//  WeatherTest
//
//  Created by Polina on 26.03.2022.
//

import Foundation

// MARK: - WeatherDataResponse
struct WeatherDataResponse: Codable {
    var cod: String
    var message, cnt: Int
    var list: [List]
    var city: City
}

// MARK: - City
struct City: Codable {
    var id: Int
    var name: String
    var coord: Coord
    var country: String
    var population, timezone, sunrise, sunset: Int
}

// MARK: - Coord
struct Coord: Codable {
    var lat, lon: Double
}

// MARK: - List
struct List: Codable {
    var dt: Int
    var main: MainClass
    var weather: [Weather]
    var visibility: Int
    var pop: Double
    var dtTxt: String
    
    enum CodingKeys: String, CodingKey {
        case dt, visibility, pop, main, weather
        case dtTxt = "dt_txt"
    }
}

// MARK: - MainClass
struct MainClass: Codable {
    var temp, feelsLike, tempMin, tempMax: Double
    var pressure, seaLevel, grndLevel, humidity: Int
    var tempKf: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}
// MARK: - Weather
struct Weather: Codable {
    var id: Int
    var weatherDescription: String
    var icon: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case weatherDescription = "description"
        case icon
    }
}

