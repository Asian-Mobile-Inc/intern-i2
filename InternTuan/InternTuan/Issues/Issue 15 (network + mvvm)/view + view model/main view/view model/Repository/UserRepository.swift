//
//  UserRepository.swift
//  InternTuan
//
//  Created by Nguên Bản on 5/12/25.
//

import Foundation
import Combine

final class UserRepository: UserRepositoryType {
    let service = APIService.shared
    
    func fetchUser() -> AnyPublisher<Result<[User], APIError>, Never> {
        service.requestPublisher(target: UserAPI.getAll)
    }
    
    func getUserById(id: String) -> AnyPublisher<Result<User, APIError>, Never> {
        service.requestPublisher(target: UserAPI.getById(id: id))
    }
}
