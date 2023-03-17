//
//  Weather.swift
//  WeatherForecast
//
//  Created by Bhavin's on 15/03/23.
//

import Foundation

struct Weather: Decodable {
    var name: String
    var main: Main
    var wind: Wind
    var coord: Coord
    
    struct Coord: Decodable {
        var lon: Double
        var lat: Double
        
        enum CodingKeys: String, CodingKey {
            case lon = "lon"
            case lat = "lat"
        }
    }
    
    struct Main: Decodable {
        var temp: Double
        var feelsLike: Double
        var tempMin: Double
        var tempMax: Double
        var pressure: Double
        var humidity: Double
        
        enum CodingKeys: String, CodingKey {
            case feelsLike = "feels_like"
            case tempMin = "temp_min"
            case tempMax = "temp_max"
            case temp
            case pressure
            case humidity
        }
    }
    
    struct Wind: Decodable {
        var speed: Double
        var deg: Double
        
        enum CodingKeys: String, CodingKey {
            case speed = "speed"
            case deg = "deg"
        }
    }
}

extension Weather {
    var temp: Double {
        return main.temp
    }
    
    var feelsLike: Double {
        return main.temp
    }
    
    var minTemperature: Double {
        return main.tempMin
    }
    
    var maxTemperature: Double {
        return main.tempMax
    }
    
    var pressure: Double {
        return main.pressure
    }
    
    var humidity: Double {
        return main.humidity
    }
    
    var windSpeed: Double {
        return wind.speed
    }
}
