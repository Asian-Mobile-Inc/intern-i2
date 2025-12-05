//
//  APIService.swift
//  InternTuan
//
//  Created by Nguên Bản on 2/12/25.
//

import Foundation
import Combine

final class APIService {
    
    static let shared = APIService()
    private init() {
        
    }
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30 //time out để nhận phản hồi
        config.timeoutIntervalForResource = 60 //time out cả quá trình (kể cả decode)
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
    
    func requestPublisher<T: Decodable> (target: APITarget) -> AnyPublisher<Result<T, APIError>, Never> {
        let request: URLRequest
        
        do {
            request = try target.asURLRequest()
        } catch let error {
            if let apiError = error as? APIError {
                return Just(.failure(apiError)).eraseToAnyPublisher()
            }
            return Just(.failure(APIError.unknownError)).eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: request)
            .mapError { APIError.urlError($0) }
            .tryMap { output -> Data in
                if let response = output.response as? HTTPURLResponse, !(200..<300).contains(response.statusCode) {
                    throw APIError.httpError(status: response.statusCode, data: output.data)
                }
                return output.data
            }
            .mapError{ error in
                if let apiError = error as? APIError {
                    return apiError
                }
                return APIError.unknownError
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .map { decoderValue in
                Result<T, APIError>.success(decoderValue)
                
            }
            .catch { error -> Just<Result<T, APIError>> in
                if let apiError = error as? APIError {
                    return Just(.failure(apiError))
                }
                return Just(.failure(APIError.unknownError))
            }
            .eraseToAnyPublisher()
    }
}
