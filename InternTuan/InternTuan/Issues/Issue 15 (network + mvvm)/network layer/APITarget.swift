//
//  APITarget.swift
//  InternTuan
//
//  Created by Nguên Bản on 1/12/25.
//

import Foundation
import Combine

protocol APITarget {
    
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var body: Data? { get }
    var queryItems: [URLQueryItem]? { get }
    
}

extension APITarget {
    func asURLRequest(authToken: String? = nil) throws -> URLRequest {
        guard var component = URLComponents(string: baseURL) else {
            throw APIError.urlError(URLError(.badURL))
        }
        
        if path.hasPrefix("/") {
            component.path += path
        } else {
            component.path += "/\(path)"
        }
        
        if let queryItems = queryItems {
            if component.queryItems == nil {
                component.queryItems = queryItems
            } else {
                component.queryItems?.append(contentsOf: queryItems)
            }
        }
        
        guard let url = component.url else {
            throw APIError.urlError(URLError(.badURL))
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        var finalHeader = headers ?? [:]
        
        if body != nil && finalHeader["Content-Type"] == nil {
            finalHeader["Content-Type"] = "application/json"
        }
        
        if let token = authToken {
            finalHeader["Authorization"] = "Bearer \(token)"
        }
        
        finalHeader.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        request.httpBody = body
        
        return request
    }
}
