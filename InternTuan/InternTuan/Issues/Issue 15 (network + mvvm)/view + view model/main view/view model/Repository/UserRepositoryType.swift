//
//  UserRepositoryType.swift
//  InternTuan
//
//  Created by Nguên Bản on 5/12/25.
//

import Foundation
import Combine

protocol UserRepositoryType {
    func fetchUser() -> AnyPublisher<Result<[User], APIError>, Never>
    func getUserById(id: String) -> AnyPublisher<Result<User, APIError>, Never>
}
