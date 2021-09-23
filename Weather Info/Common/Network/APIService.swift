//
//  APIService.swift
//  Weather Info
//
//  Created by Muhammad Omer on 23/9/21.
//

import Foundation

class APIService {
    
    static let shared = APIService()
    
    func callApi(onSuccess: @escaping(Weather)->(),
                 onError: @escaping (ErrorResponse?)->()) {
        
        guard let url = AppConstants.shared.getUrl() else {
            onError(ErrorResponse(cod: -1, message: "Invalid Url"))
            return
        }
        
        var request = URLRequest(url: url)
        request.timeoutInterval = 60
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    let error = ErrorResponse(cod: -1, message: error.localizedDescription)
                    onError(error)
                    return
                }
                
                
                guard let data = data, let response = response as? HTTPURLResponse else {
                    onError(ErrorResponse(cod: -1, message: "Invalid responce"))
                    return
                }
                
                
                do {
                    if response.statusCode == 200 {
                        let jsonObject = try JSONDecoder().decode(Weather.self, from: data)
                        onSuccess(jsonObject)
                    } else {
                        onError(ErrorResponse(cod: response.statusCode, message: response.description))
                    }
                } catch {
                    onError(ErrorResponse(cod: -1, message: error.localizedDescription))
                }
            }
        }
        task.resume()
    }
}
