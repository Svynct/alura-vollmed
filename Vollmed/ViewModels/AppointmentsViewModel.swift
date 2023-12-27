//
//  AppointmentsViewModel.swift
//  Vollmed
//
//  Created by Ricardo dos Santos Amaral on 27/12/23.
//

import Foundation

struct AppointmentsViewModel {
    
    // MARK: - Attributes
    
    let service: AppointmentsNetworkingServiceable
    
    // MARK: - Init
    
    init(service: AppointmentsNetworkingServiceable) {
        self.service = service
    }
    
    // MARK: - Class methods
    
    func getAllAppointmentsFromPatient() async throws -> [Appointment]? {
        let result = await service.getAllAppointmentsFromPatient()
        
        switch result {
        case .success(let response):
            return response
        case .failure(let error):
            print(error)
            throw error
        }
    }
}
