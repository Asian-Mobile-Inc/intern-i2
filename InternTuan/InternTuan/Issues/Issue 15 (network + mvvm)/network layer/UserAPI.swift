//
//  UserAPI.swift
//  InternTuan
//
//  Created by Nguên Bản on 2/12/25.
//

import Foundation

enum UserAPI {
    case getAll
    case getById(id: String)
}

extension UserAPI: APITarget {
    
    var baseURL: String { "https://jsonplaceholder.typicode.com" }
    
    var path: String {
        switch self {
        case .getAll:
            return "/users"
        case .getById(let id):
            return "/users/\(id)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getAll, .getById:
            return .GET
        }
    }
    
    var headers: [String : String]? {
        nil
    }
    
    var body: Data? {
        nil
    }
    
    var queryItems: [URLQueryItem]? {
        nil
    }
}
