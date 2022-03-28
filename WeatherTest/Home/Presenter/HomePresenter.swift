//
//  HomePresenter.swift
//  WeatherTest
//
//  Created by Polina on 26.03.2022.
//

import Foundation
import RealmSwift

protocol HomeView: AnyObject {
    
    func reloadView(city: WeatherCityToday, futureWeather: [WeatherCityFuture])
    
    func changeTemp(isCelsius: Bool, city: WeatherCityToday, futureWeather: [WeatherCityFuture] )
}

final class HomePresenter {
    
    //MARK: - Public Properties
    var isCelsius = true
    var cityDefault = CitySourse(name: "Москва", lon: 37.615555, lat: 55.75222, isSelected: true)
    
    //MARK: - Private Properties
    private weak var view: HomeView?
    private let networkAPIManager = NetworkAPIManager()
    private var weatherData: WeatherDataResponse?
    private var weatherCity: WeatherCityToday?
    // FOR REALM
    //    private var weatherCity: Results<WeatherCityToday>?
    //    private var weathersFuture: Results<WeatherCityFuture>?
    private var weathersFuture: [WeatherCityFuture]?
    private var weatherHoursCurrentDay = [List]()
    private var weatherHoursTomorrow = [List]()
    private var weatherHoursThreeDay = [List]()
    private var weatherHoursFourDay = [List]()
    private var weatherHoursFiveDay = [List]()
    
    // MARK: - Lifecycle Methods
    init(view: HomeView) {
        self.view = view
        fetchWeatherResponse(city: cityDefault)
    }
    
    //MARK: - Public Methods
    func changeTempUnit() {
        //realm
//        guard let city = weatherCity?.first, let futureWeather = weathersFuture else {return}
//        self.view?.changeTemp(isCelsius: isCelsius, city: city, futureWeather: Array(futureWeather))
        guard let city = weatherCity, let futureWeather = weathersFuture else {return}
        self.view?.changeTemp(isCelsius: isCelsius, city: city, futureWeather: futureWeather)
        
    }
    
    //MARK: - Private Methods
    func fetchWeatherResponse(city: CitySourse) {
        networkAPIManager.getWeatherObjectsResponse(lat: city.lat, lon: city.lon) { [weak self] result in
            switch result {
            case .success(let weatherObject):
                self?.createdDaysArray(weatherByHours: weatherObject.list)
                
                // FOR REALM
//                let tempWeatherCity = self?.createdWeatherCity(city: weatherObject, weather: self?.weatherHoursCurrentDay ?? weatherObject.list)
//                let itemWeathersFuture = self?.createdArrayWeathersFuture()
//                DispatchQueue.main.async {
//                    if let data = tempWeatherCity, let feature = itemWeathersFuture {
//                        RealmManager.save(items: [data])
//                        RealmManager.save(items: feature)
//                        guard let city = self?.weatherCity?.first, let futureWeather = self?.weathersFuture else {return}
//                        self?.view?.reloadView(city: city, futureWeather: Array(futureWeather))
//                    }
//                }
                
                self?.weatherCity = self?.createdWeatherCity(city: weatherObject, weather: self?.weatherHoursCurrentDay ?? weatherObject.list)
                self?.weathersFuture = self?.createdArrayWeathersFuture()
                DispatchQueue.main.async {
                    guard let city = self?.weatherCity, let futureWeather = self?.weathersFuture else {return}
                    self?.view?.reloadView(city: city, futureWeather: futureWeather)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        // FOR REALM
//        let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
//        let realm = try? Realm(configuration: config)
//        self.weatherCity = realm?.objects(WeatherCityToday.self)
//        self.weathersFuture = realm?.objects(WeatherCityFuture.self)
//
//        DispatchQueue.main.async {
//            guard let city = self.weatherCity?.first, let futureWeather = self.weathersFuture else {return}
//            self.view?.reloadView(city: city, futureWeather: Array(futureWeather))
//        }
    }
    
    private func createdArrayWeathersFuture() -> [WeatherCityFuture] {
        let weatherDays = [weatherHoursCurrentDay, weatherHoursTomorrow, weatherHoursThreeDay, weatherHoursFourDay, weatherHoursFiveDay]
        var weathersFuture = [WeatherCityFuture]()
        
        for weather in weatherDays {
            let weatherFuture = creteadWeatherCityFuture(weather: weather)
            weathersFuture.append(weatherFuture)
        }
        return weathersFuture
    }
    
    private func createdWeatherCity(city: WeatherDataResponse, weather: [List]) -> WeatherCityToday? {
        let name = city.city.name
        guard let temp = searchCurrentWeatherTempAndDescription().0 else {return nil}
        let tempC = convertTempKelvinToCelsius(tempK: temp)
        let tempF = convertTempKelvinToFarengeit(tempK: temp)
        guard let description = searchCurrentWeatherTempAndDescription().1 else {return nil}
        let weatherSortedTemp = weather.sorted(by: { $0.main.temp < $1.main.temp } )
        let tempMin = weatherSortedTemp.first?.main.temp
        let tempMax = weatherSortedTemp.last?.main.temp
        let tempCMin = convertTempKelvinToCelsius(tempK: tempMin ?? 0)
        let tempCMax = convertTempKelvinToCelsius(tempK: tempMax ?? 0)
        let tempFMin = convertTempKelvinToFarengeit(tempK: tempMin ?? 0)
        let tempFMax = convertTempKelvinToFarengeit(tempK: tempMax ?? 0)
        
        let weatherCity = WeatherCityToday(name: name, tempF: tempF, tempC: tempC, weatherDescription: description, tempCMin: tempCMin, tempCMax: tempCMax, tempFMin: tempFMin, tempFMax: tempFMax)
        
        return weatherCity
    }
    
    private func creteadWeatherCityFuture(weather: [List]) -> WeatherCityFuture {
        let dateString = weather.first?.dtTxt ?? ""
        let dateFormater = dateFormater(dateString: dateString)
        let icon = weather.first?.weather[0].icon ?? ""
        let sortedWeathersTemp = weather.sorted { $0.main.temp < $1.main.temp }
        
        let tempMin = sortedWeathersTemp.first?.main.temp
        let tempMax = sortedWeathersTemp.last?.main.temp
        
        let tempFMin = convertTempKelvinToFarengeit(tempK: tempMin ?? 0)
        let tempFMax = convertTempKelvinToFarengeit(tempK: tempMax ?? 0)
        let tempCMin = convertTempKelvinToCelsius(tempK: tempMin ?? 0)
        let tempCMax = convertTempKelvinToCelsius(tempK: tempMax ?? 0)
        let weatherCityFuture = WeatherCityFuture(tempCMin: tempCMin, tempCMax: tempCMax, tempFMin: tempFMin, tempFMax: tempFMax, icon: icon, dateString: dateFormater)
        return weatherCityFuture
    }
    
    private func convertTempKelvinToCelsius(tempK: Double) -> String {
        let tempC = Int(tempK) - 273
        return "\(tempC)°С"
    }
    
    private func convertTempKelvinToFarengeit(tempK: Double) -> String {
        let tempF = Int(1.8 * (tempK - 273) + 32)
        return "\(tempF)°F"
    }
    
    private func getCurrentDay() -> Int {
        let dateCurrent = Date()
        let dateDay = Int(dateCurrent.getFormattedDate(format: "dd"))
        return dateDay ?? 0
    }
    
    private func createdDaysArray(weatherByHours: [List]) {
        weatherHoursCurrentDay.removeAll()
        weatherHoursTomorrow.removeAll()
        weatherHoursThreeDay.removeAll()
        weatherHoursFourDay.removeAll()
        weatherHoursFiveDay.removeAll()
        let dayCurrent = getCurrentDay()
        for weatherByHour in weatherByHours {
            let day = getDayFromDate(dateString: weatherByHour.dtTxt)
            switch day {
            case dayCurrent:
                weatherHoursCurrentDay.append(weatherByHour)
            case dayCurrent + 1:
                weatherHoursTomorrow.append(weatherByHour)
            case dayCurrent + 2:
                weatherHoursThreeDay.append(weatherByHour)
            case dayCurrent + 3:
                weatherHoursFourDay.append(weatherByHour)
            case dayCurrent + 4:
                weatherHoursFiveDay.append(weatherByHour)
            default: break
            }
        }
    }
    
    private func searchCurrentWeatherTempAndDescription() -> (Double?,String?) {
        let currentWeatherTemp = weatherHoursCurrentDay.first?.main.temp
        let currentWeatherDescription = weatherHoursCurrentDay.first?.weather[0].weatherDescription
        return (currentWeatherTemp, currentWeatherDescription)
    }
    
    private func getDayFromDate(dateString: String) -> Int {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = formatter.date(from: dateString) else {return 0}
        
        formatter.dateFormat = "dd"
        let day = Int(formatter.string(from: date))
        return day ?? 0
    }
    
    private func dateFormater(dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = formatter.date(from: dateString) else {return ""}
        
        formatter.dateFormat = "dd.MM.yy"
        let dateFormat = formatter.string(from: date)
        return dateFormat
    }
}
