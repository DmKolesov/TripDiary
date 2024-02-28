//
//  WeatherService.swift
//  TripDiary
//
//  Created by TX 3000 on 31.07.2023.
//

import Foundation
import Alamofire

// MARK: - Weather Service Protocol
protocol WeatherService {
    func fetchWeatherTemperature(for location: String, completion: @escaping (String?) -> Void)
}

// MARK: - Weather Details Structure
struct WeatherDetails: Decodable {
    let temp: Double
}

// MARK: - Weather Response Structure
struct WeatherResponse: Decodable {
    let main: WeatherDetails
}

// MARK: - OpenWeatherMapService Implementation
class OpenWeatherMapService: WeatherService {
    private let apiKey = "afa0ca1adcdd41edcb18aaf687f9d345"
    
    func fetchWeatherTemperature(for location: String, completion: @escaping (String?) -> Void) {
        let weatherURL = "https://api.openweathermap.org/data/2.5/weather"
        let parameters: Parameters = [
            "q": location,
            "appid": apiKey,
            "units": "metric"
        ]
        
        AF.request(weatherURL, parameters: parameters).responseDecodable(of: WeatherResponse.self) { response in
            switch response.result {
            case .success(let weatherResponse):
                let temperatureString = String(format: "%.1f°C", weatherResponse.main.temp)
                completion(temperatureString)
            case .failure(let error):
                print("Error fetching weather data: \(error)")
                completion(nil)
            }
        }
    }
}
