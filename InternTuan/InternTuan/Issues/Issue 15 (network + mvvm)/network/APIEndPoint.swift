//
//  API.swift
//  InternTuan
//
//  Created by Nguên Bản on 28/11/25.
//

import Foundation

// Khai báo enum HTTPMethod để dùng an toàn thay vì String tự do.
enum HTTPMethod: String {
    case GET, POST, PUT, PATCH, DELETE
}

protocol APITarget {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }              // Đổi từ String sang HTTPMethod
    var headers: [String: String]? { get }
    var body: Data? { get }
    var queryItems: [URLQueryItem]? { get }     // Thêm queryItems để dùng trong URLComponents
}

extension APITarget {
    func asURLRequest(authToken: String? = nil) throws -> URLRequest {
        // Dùng URLComponents để build URL an toàn (tránh lỗi khi có query/encode).
        guard var components = URLComponents(string: baseURL) else {
            throw URLError(.badURL)
        }
        // Đảm bảo path ghép đúng (tránh double slash hoặc thiếu slash).
        let normalizedPath: String
        if path.hasPrefix("/") {
            normalizedPath = path
        } else {
            normalizedPath = "/" + path
        }
        components.path = components.path.appending(normalizedPath)
        if let queryItems = queryItems, !queryItems.isEmpty {
            components.queryItems = queryItems
        }
        guard let url = components.url else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        // Header mặc định cho JSON nếu có body (POST/PUT...) trừ khi caller override.
        var finalHeaders: [String: String] = headers ?? [:]
        if body != nil && finalHeaders["Content-Type"] == nil {
            finalHeaders["Content-Type"] = "application/json"
        }
        if finalHeaders["Accept"] == nil {
            finalHeaders["Accept"] = "application/json"
        }

        // Nếu có truyền token thì gắn Authorization Bearer token vào header.
        if let token = authToken {
            finalHeaders["Authorization"] = "Bearer \(token)"
        }

        // Apply headers
        for (key, value) in finalHeaders {
            request.setValue(value, forHTTPHeaderField: key)
        }

        // Gắn body (nếu có). Với GET nên để nil.
        request.httpBody = body
        return request
    }
}


enum UserAPI: APITarget {
    case getAll
    case getById(String)

    var baseURL: String {
        "https://jsonplaceholder.typicode.com"
    }

    var path: String {
        switch self {
        case .getAll:
            return "/users"
        case .getById(let id):
            return "/users/\(id)"
        }
    }

    var method: HTTPMethod {
        .GET
    }

    var headers: [String : String]? {
        ["Accept": "application/json"]
    }

    var body: Data? {
        nil
    }

    var queryItems: [URLQueryItem]? {
        nil
    }
}

