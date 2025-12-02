//
//  APIService.swift
//  InternTuan
//
//  Created by Nguên Bản on 2/12/25.
//

import Foundation

final class APIService {
    
    static let shared = APIService()
    private init() {
        
    }
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30 //giải thích thêm
        config.timeoutIntervalForResource = 60 //giải thích thêm
        return URLSession(configuration: config)
    }()
}

extension APIService {
    func request<T: Decodable> (target: APITarget) async throws -> T {
        
        let request: URLRequest
        
        do {
            request = try target.asURLRequest()
        } catch let urlError as URLError {
            throw APIError.urlError(urlError)
        } catch {
            throw APIError.unknownError
        }
        
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.unknownError
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                if httpResponse.statusCode == 401 {
                    throw APIError.unauthorized
                }
                throw APIError.httpError(status: httpResponse.statusCode, data: data)
            }
            
            do {
                let data = try JSONDecoder().decode(T.self, from: data)
                return data
            } catch {
                throw APIError.decodingError(error)
            }
            
        } catch let urlError as URLError {
            throw APIError.urlError(urlError)
        } catch let apiError as APIError {
            throw apiError
        } catch {
            throw APIError.unknownError
        }
    }
}
