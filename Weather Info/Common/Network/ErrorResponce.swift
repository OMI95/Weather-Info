//
//  ErrorResponce.swift
//  Weather Info
//
//  Created by Muhammad Omer on 23/9/21.
//

import Foundation

class ErrorResponse: Codable {
    var cod: Int?
    var message: String?
    
    init(cod: Int, message: String) {
        self.cod = cod
        self.message = message
    }
    
    private enum CodingKeys: String, CodingKey {
        case cod
        case message
    }
}
