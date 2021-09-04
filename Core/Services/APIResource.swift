//
//  APIResource.swift
//  Core
//
//  Created by armin on 7/22/21.
//

import Foundation

protocol APIResource {
    associatedtype ModelType: Decodable
    var key: String? { get }
    var type: String? { get }
    var participants: String? { get }
    var minprice: String? { get }
    var maxprice: String? { get }
    var accessibility: String? { get }
    var minaccessibility: String? { get }
    var maxaccessibility: String? { get }
}

extension APIResource {
    var url: URL {
        var components = URLComponents(string: "\(Constants.BaseAPI)")!
        components.queryItems = []
        
        if let key = key {
            components.queryItems?.append(URLQueryItem(name: "key", value: key))
        }
        
        if let type = type {
            if type != "all" && type != "" {
                components.queryItems?.append(URLQueryItem(name: "type", value: type))
            }
        }
        
        if let participants = participants {
            components.queryItems?.append(URLQueryItem(name: "participants", value: participants))
        }
        
        if let minprice = minprice {
            components.queryItems?.append(URLQueryItem(name: "minprice", value: minprice))
        }
        
        if let maxprice = maxprice {
            components.queryItems?.append(URLQueryItem(name: "maxprice", value: maxprice))
        }
        
        if let accessibility = accessibility {
            components.queryItems?.append(URLQueryItem(name: "accessibility", value: accessibility))
        }
        
        if let minaccessibility = minaccessibility {
            components.queryItems?.append(URLQueryItem(name: "minaccessibility", value: minaccessibility))
        }
        
        if let maxaccessibility = maxaccessibility {
            components.queryItems?.append(URLQueryItem(name: "maxaccessibility", value: maxaccessibility))
        }
        
        return components.url!
    }
}
