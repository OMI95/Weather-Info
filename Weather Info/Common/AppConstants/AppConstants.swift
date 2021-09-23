//
//  AppConstants.swift
//  Weather Info
//
//  Created by Muhammad Omer on 23/9/21.
//

import Foundation

class AppConstants {
    private let baseURL = "http://api.openweathermap.org/data/2.5/group?"
    private let APIKey = "&units=metric&appid=72b590840d51311be0fc13b2646e1d10"
    
    static let shared = AppConstants()
    private var cityIds = "id=4163971,2147714,2174003"
    
    func getUrl() -> URL? {
        return URL(string: baseURL + cityIds + APIKey)
    }
    
    func updateCityIds(id: String) {
        if !self.cityIds.lowercased().contains(id) {
            self.cityIds += "," + id
        }
    }
    
    func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
}
