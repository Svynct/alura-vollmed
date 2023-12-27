//
//  AppointmentsEndpoint.swift
//  Vollmed
//
//  Created by Ricardo dos Santos Amaral on 27/12/23.
//

import Foundation

enum AppointmentsEndpoint {
    case getAllAppointments
}

extension AppointmentsEndpoint: Endpoint {
    var path: String {
        switch self {
        case .getAllAppointments:
            guard let patientID = AuthenticationManager.shared.patientID else {
                return ""
            }
            return "/paciente/" + patientID + "/consultas"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .getAllAppointments:
            return .get
        }
    }
    
    var header: [String : String]? {
        switch self {
        case .getAllAppointments:
            guard let token = AuthenticationManager.shared.token else { return nil }
            return [
                "Authorization": "Bearer \(token)",
                "Content-Type": "application/json"
            ]
        }
    }
    
    var body: [String : String]? {
        switch self {
        case .getAllAppointments:
            return nil
        }
    }
}
