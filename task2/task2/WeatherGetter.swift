//
//  WeatherGetter.swift
//  task2
//
//  Created by Anton on 5/27/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation


class WeatherGetter {
  
    static let apiKey = "0160d00b-6615-459e-9006-8e7e4c87b655"
    
    static func getTemperature(latitude: Double, longitude: Double, completition: @escaping (_ temperature:Double) -> Void) {
        
        var request = URLRequest(url: URL(string: "https://api.weather.yandex.ru/v1/informers?lat=" +
            String(latitude) + "&lon=" + String(longitude) + "&lang=ru_Ru")!)
        request.setValue(apiKey, forHTTPHeaderField: "X-Yandex-API-Key")
        request.httpMethod = "GET"
        print(request)
       
        var temperature: Double = 0
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            do {
                print(response)
                let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                let fact = json["fact"] as! [String: Any]
                temperature = fact["temp"] as! Double
                
                print("Temperature: \(temperature)")
                DispatchQueue.main.async() {completition(temperature)}
                
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}

