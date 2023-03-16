//
//  NetworkController.swift
//  WeatherForecast
//
//  Created by Bhavin's on 15/03/23.
//

import Foundation

struct NetworkController {
    
    private static var baseUrl = "api.openweathermap.org"
    private static let apiKey = "8756cf452414908d61949b705f1bf16c"
    
    enum Endpoint {
        case cityId(path: String = "/data/2.5/weather", id: Int)
        case latLong(path: String = "/data/2.5/weather", lat: Double, long: Double)
        
        var url: URL? {
            var components = URLComponents()
            
            components.scheme = "https"
            components.host = baseUrl
            components.path = path
            components.queryItems = queryItems
            
            return components.url
        }
        
        private var path: String {
            switch self {
            case .cityId(let path, _):
                return path
            case .latLong(let path, _, _):
                return path
            }
        
        }
        
        private var queryItems: [URLQueryItem] {
            
            var queryItems = [URLQueryItem]()
            
            switch self {
            case .cityId(_, let id):
                queryItems.append(URLQueryItem(name: "id", value: String(id)))
            case .latLong(_, let lat, let long):
                queryItems.append(URLQueryItem(name: "lat", value: String(lat)))
                queryItems.append(URLQueryItem(name: "lon", value: String(long)))
            }
            
            queryItems.append(URLQueryItem(name: "appid", value: apiKey))
            
            return queryItems
        }
    }
    
    // 5128581 is New York
    static func fetchWeather(for cityId: Int, _ completion: @escaping ((Weather) -> Void)) {
        if let url = Endpoint.cityId(id: cityId).url {
            print("URL ==> \(url)")
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Whoops, and error occured!", error)
                }
                
                if let data = data {
                    do {
                        let weather = try JSONDecoder().decode(Weather.self, from: data)
                        completion(weather)
                    } catch let error {
                        print("failed to decode object...", error)
                    }
                    
                }
            }.resume()
        }
        
    }
      static func fetchWeatherWithLatLong(for lat: Double, long: Double, _ completion: @escaping ((Weather) -> Void)) {
            if let url = Endpoint.latLong(lat: lat, long: long).url {
                print("URL ==> \(url)")
                URLSession.shared.dataTask(with: url) { (data, response, error) in
                    if let error = error {
                        print("Whoops, and error occured!", error)
                    }
                    
                    if let data = data {
                        do {
                            let weather = try JSONDecoder().decode(Weather.self, from: data)
                            completion(weather)
                        } catch let error {
                            print("failed to decode object...", error)
                        }
                        
                    }
                }.resume()
            }
    }
    
//    static func fetchMailMessages(_ completion: @escaping (([Mail.Messsage]) -> Void)) {
//
//    }
    
}
