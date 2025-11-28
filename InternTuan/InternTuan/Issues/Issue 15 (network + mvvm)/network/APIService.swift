//
//  APIService.swift
//  InternTuan
//
//  Created by Nguên Bản on 28/11/25.
//

import Foundation

// Các loại lỗi có thể xảy ra trong quá trình gọi API.
enum APIError: Error {
    case urlError(URLError)                  // Lỗi ở tầng URLSession/Network (mất mạng, timeout, DNS...)
    case httpError(status: Int, data: Data?) // Server trả về mã lỗi HTTP (4xx/5xx), kèm data (nếu có)
    case decodingError(Error)                // Lỗi parse JSON sang model Decodable
    case unauthorized                        // Lỗi chưa/không được ủy quyền (401) sau khi đã thử refresh token
    case unknown                             // Lỗi không xác định
}

// Service sử dụng async/await để gọi API một cách generic.
final class APIServiceAsync {
    static let shared = APIServiceAsync()    // Singleton dùng chung
    private init() {}

    // Lưu token (ví dụ). Trong thực tế, bạn có thể lấy từ Keychain, UserDefaults, hoặc từ AuthManager.
    private var authToken: String? = "initial_token"

    // Cấu hình JSONDecoder dùng chung (có thể set dateDecodingStrategy, keyDecodingStrategy...).
    private let decoder: JSONDecoder = {
        let d = JSONDecoder()
        // d.keyDecodingStrategy = .convertFromSnakeCase
        // d.dateDecodingStrategy = .iso8601
        return d
    }()

    // URLSession cấu hình timeout, cache policy...
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        config.timeoutIntervalForResource = 60
        return URLSession(configuration: config)
    }()

    // Hàm request generic: nhận một APITarget và trả về kiểu Decodable T.
    // - Tự động thêm Authorization header nếu có authToken
    // - Tự động parse JSON về T
    // - Tự động xử lý 401 bằng cách refresh token rồi gọi lại 1 lần
    func request<T: Decodable>(_ target: APITarget) async throws -> T {
        // Tạo URLRequest từ target, kèm token hiện tại (nếu có).
        var request: URLRequest
        do {
            request = try target.asURLRequest(authToken: authToken)
        } catch let urlErr as URLError {
            throw APIError.urlError(urlErr)
        } catch {
            throw APIError.unknown
        }

        do {
            // Gọi network bằng async/await.
            let (data, response) = try await session.data(for: request)

            // Ép kiểu response về HTTPURLResponse để đọc status code.
            guard let httpRes = response as? HTTPURLResponse else {
                throw APIError.unknown
            }

            switch httpRes.statusCode {
            case 200...299:
                // Thành công: decode JSON sang model T.
                do {
                    return try decoder.decode(T.self, from: data)
                } catch {
                    throw APIError.decodingError(error)
                }

            case 401:
                // Unauthorized: thử refresh token.
                try await refreshToken()
                // Tạo lại request với token mới.
                request = try target.asURLRequest(authToken: authToken)
                // Gọi lại 1 lần.
                let (newData, newResponse) = try await session.data(for: request)
                guard let newHttp = newResponse as? HTTPURLResponse else {
                    throw APIError.unknown
                }
                guard (200...299).contains(newHttp.statusCode) else {
                    // Nếu vẫn không thành công, ném lỗi unauthorized để caller xử lý (ví dụ: logout).
                    throw APIError.unauthorized
                }
                do {
                    return try decoder.decode(T.self, from: newData)
                } catch {
                    throw APIError.decodingError(error)
                }

            default:
                // Các mã lỗi HTTP khác: ném httpError kèm mã và data (để debug/log).
                throw APIError.httpError(status: httpRes.statusCode, data: data)
            }

        } catch let urlErr as URLError {
            // Lỗi mạng/tầng URLSession.
            throw APIError.urlError(urlErr)
        } catch let apiErr as APIError {
            throw apiErr
        } catch {
            throw APIError.unknown
        }
    }

    // Hàm giả lập refresh token (trong thực tế sẽ gọi endpoint refresh).
    // Lưu ý: Trong app thật, bạn nên đồng bộ hoá để tránh nhiều request cùng lúc refresh token.
    private func refreshToken() async throws {
        print("Refreshing token...")
        try await Task.sleep(nanoseconds: 1_000_000_000) // Delay 1 giây giả lập
        authToken = "new_token_123"
        print("Token refreshed")
    }
}

