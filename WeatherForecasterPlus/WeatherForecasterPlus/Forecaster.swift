//
//  ForeCaster.swift
//  WeatherForecaster
//
//  Created by Yukinaga2 on 2017/12/06.
//  Copyright © 2017年 Yukinaga Azuma. All rights reserved.
//

import UIKit

class Forecaster: NSObject {
    
    static func forecast(cityName:String, completion:@escaping (ForecastResult)->Void){
        
        let appID = "347ac8f1962a843838d26d1f3a1c8912"
        let urlString = "http://api.openweathermap.org/data/2.5/forecast?units=metric&q=" + cityName + "&APPID=" + appID
        guard let url = URL(string: urlString) else {
            print("URL error")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let jsonData = data else {
                print("JSON data error")
                return
            }
            
            do {
                let result:ForecastResult = try JSONDecoder().decode(ForecastResult.self, from: jsonData)
                completion(result)
            }catch let error{
                print(error)
            }
        }
        task.resume()
    }
}

struct ForecastResult: Codable{
    var list:[Forecast]
}

struct Forecast: Codable {
    var dt_txt:String
    var main:Main
    var weather:[Weather]
    
    struct Main: Codable {
        var temp: Double
        var pressure: Double
        var humidity: Int
    }
    
    struct Weather: Codable {
        var description: String
        var id: Int
        var main: String
    }
    
    func getFormattedTemp() -> String{
        return String(format: "%.1f ℃", main.temp)
    }
    
    func getFormattedPressure() -> String{
        return String(format: "%.2f hPa", main.pressure)
    }
    
    func getFormattedHumidity() -> String{
        return String(format: "Humidity: %d ％", main.humidity)
    }
    
    func getDescription() -> String{
        return weather.count > 0 ? weather[0].description : ""
    }
    
    func getIconText() -> String {
        if weather.count == 0 {
            return ""
        }
        // 次を参考: https://openweathermap.org/weather-conditions
        switch weather[0].id {
        case 200..<300: return "⚡️"
        case 300..<400: return "🌫"
        case 500..<600: return "☔️"
        case 600..<700: return "⛄️"
        case 700..<800: return "🌪"
        case 800: return "☀️"
        case 801..<900: return "☁️"
        case 900..<1000: return "🌀"
        default: return "☁️"
        }
    }
    
    func getMain() -> String {
        return weather.count > 0 ? weather[0].main : ""
    }
}
