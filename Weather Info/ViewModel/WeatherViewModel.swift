//
//  WeatherViewModel.swift
//  Weather Info
//
//  Created by Muhammad Omer on 23/9/21.
//

import Foundation

class WeatherViewModel {
    static let shared = WeatherViewModel()
    let apiSerivce = APIService.shared
    
    var citiesWeatherList: Weather? {
        didSet {
            didFinishCalling?()
        }
    }
    
    var error: ErrorResponse? {
        didSet {
            showAlertClosure?()
        }
    }
    
    var isLoading: Bool = false {
        didSet {
            updateLoadingStatus?()
        }
    }
    
    // MARK: - Callbacks
    var showAlertClosure: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    var didFinishCalling: (() -> ())?
    
    //get weathers
    func getWeathers() {
        apiSerivce.callApi { (data) in
            self.isLoading = false
            do {
                self.citiesWeatherList = data
            }
        } onError: { error in
            self.isLoading = false
            var code = -1
            var message = "No Responce"
            if let err = error {
                if let cod = err.cod {
                    code = cod
                }
                if let msg = err.message {
                    message = msg
                }
            }
            let error = ErrorResponse(cod: code, message: message)
            self.error = error
        }
    }
}
