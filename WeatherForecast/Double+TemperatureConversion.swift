//
//  Double+TemperatureConversion.swift
//  WeatherForecast
//
//  Created by Bhavin's on 15/03/23.
//

import Foundation

extension Double {
    var kelvinToFahrenheit: Double {
        return (9.0 / 5) * (self - 273) + 32
    }
}
