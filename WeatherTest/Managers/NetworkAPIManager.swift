//
//  NetworkAPIManager.swift
//  WeatherTest
//
//  Created by Polina on 26.03.2022.
//

import Foundation

final class NetworkAPIManager {
    
    // MARK: - Private Properties
    private var apiKEY = "266d704789c0424d2cbed38f9c150101"
    private var baseURL = URL(string: "https://api.openweathermap.org/data/2.5/forecast")!
    
    // MARK: - Public Methods
    func getWeatherObjectsResponse(lat: Double, lon: Double, completionHandler: @escaping (Result<WeatherDataResponse, Error>) -> Void ) {
        
        guard let urlRequest = createdURL(lat: lat, lon: lon) else {return}
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data else {return}
            do {
                let weatherDataResponse = try JSONDecoder().decode(WeatherDataResponse.self, from: data)
                completionHandler(.success(weatherDataResponse))
            } catch {
                completionHandler(.failure(error))
            }
        }.resume()
    }
    
    // MARK: - Private Methods
    private func createdURL(lat: Double, lon: Double) -> URL? {
        var components = URLComponents()
        components.scheme = baseURL.scheme
        components.host = baseURL.host
        components.path = baseURL.path
        components.queryItems = [
            URLQueryItem(name: "lat", value: lat.description),
            URLQueryItem(name: "lon", value: lon.description),
            URLQueryItem(name: "lang", value: "RU"),
            URLQueryItem(name: "appid", value: apiKEY)
        ]
        return components.url
        
    }
}
