//
//  APIError.swift
//  InternTuan
//
//  Created by Nguên Bản on 1/12/25.
//

import Foundation

enum APIError: Error {
    case urlError(URLError)
    case httpError(status: Int, data: Data?)
    case decodingError(Error)
    case unauthorized
    case unknownError
}
