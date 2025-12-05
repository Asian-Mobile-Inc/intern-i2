//
//  Issue15MainViewModel.swift
//  InternTuan
//
//  Created by Nguên Bản on 28/11/25.
//

import Foundation
import Combine
import OSLog

final class Issue15MainViewModel {
    let logger = Logger()
    
    @Published private(set) var users: [User] = []
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var error: APIError? = nil
    
    var cancellable = Set<AnyCancellable>()
    
    let dataManager = DataManager.shared()
    
    let repository: UserRepositoryType
    
    init(repository: UserRepositoryType) {
        self.repository = repository
    }
}

//MARK: API
extension Issue15MainViewModel {
    public func fetchData() {
        self.isLoading = true
        
        repository.fetchUser()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                guard let self = self else {
                    return
                }
                
                self.isLoading = false
                
                switch result {
                case .success(let users):
                    self.users = users
                    break
                case .failure(let error):
                    logger.error("\(error)")
                    self.error = error
                    break
                }
            }
            .store(in: &cancellable)
    }

    func getUserById(id: String) {
        self.isLoading = true
        
        repository.getUserById(id: id)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                guard let self = self else {
                    return
                }
                
                self.isLoading = false
                
                switch result {
                case .success(let user):
                    self.users = [user]
                    break
                case .failure(let error):
                    logger.error("\(error)")
                    self.error = error
                    break
                }
            }
            .store(in: &cancellable)
    }
}
