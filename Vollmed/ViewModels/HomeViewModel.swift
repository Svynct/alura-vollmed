//
//  HomeViewModel.swift
//  Vollmed
//
//  Created by Ricardo dos Santos Amaral on 27/12/23.
//

import Foundation

struct HomeViewModel {
    
    // MARK: - Attributes
    
    let service: HomeServiceable
    let authService: AuthenticationServiceable
    
    // MARK: - Init
    
    init(service: HomeServiceable, authService: AuthenticationServiceable) {
        self.service = service
        self.authService = authService
    }
    
    // MARK: - Class methods
    
    func getSpecialists() async throws -> [Specialist]? {
        let result = try await service.getAllSpecialists()
        
        switch result {
        case .success(let response):
            return response
        case .failure(let error):
            throw error
        }
    }
    
    func logout() async {
        let result = await authService.logout()
        
        switch result {
        case .success(_ ):
            AuthenticationManager.shared.removeToken()
            AuthenticationManager.shared.removePatientID()
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
