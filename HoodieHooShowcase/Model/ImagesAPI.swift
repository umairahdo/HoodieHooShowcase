//
//  ImagesAPI.swift
//  HoodieHooShowcase
//
//  Created by Umair Ahmad on 20/01/23.
//

import Foundation

enum ImagesAPI {
    case getImageList
}

extension ImagesAPI {
    var baseURL: String {
        return "https://tech.hoodiehoo.com"
    }
    
    var apiKey: String {
        return Bundle.main.object(forInfoDictionaryKey: "API_KEY") as! String
    }
    
    var path: String {
        switch self {
        case .getImageList:
            return "/api/test"
        }
    }
    
    var method: String {
        switch self {
        default:
            return "GET"
        }
    }
    
    var querys: [String: String]? {
        switch self {
        case .getImageList:
            return ["apiKey": self.apiKey]
        }
    }
}

