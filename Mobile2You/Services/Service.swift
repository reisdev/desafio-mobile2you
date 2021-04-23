//
//  Service.swift
//  Mobile2You
//
//  Created by ReisDev on 22/04/21.
//

import Foundation

enum RequestError: Error {
    case serverUnavailable
    case unauthorized
    case notFound
    case unknown
}

extension RequestError: LocalizedError {
    var localizedDescription: String {
        switch self {
        case .serverUnavailable:
            return NSLocalizedString("Unable to communicate with server. Try again later", comment: "Server unavailable")
        case .unauthorized:
            return NSLocalizedString("Authorization error. Please, contact the development team", comment: "Unauthorized")
        case .notFound:
            return NSLocalizedString("Resource not found", comment: "Not found")
        case .unknown:
            return NSLocalizedString("An unknown error has ocurred", comment: "Unknown error")
        }
    }
}

protocol ServiceProtocol {
    var apiURL: String {get};
    var apiKey: String {get};
    var endpoint: String{get};
}

class Service: ServiceProtocol {
    var endpoint: String    
    var apiURL : String = "https://api.themoviedb.org/3";
    var apiKey: String = ProcessInfo.processInfo.environment["API_KEY"] ?? "";
    
    init(endpoint: String){
        self.endpoint = endpoint
    }
}
