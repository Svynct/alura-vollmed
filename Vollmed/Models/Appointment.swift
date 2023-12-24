//
//  Appointment.swift
//  Vollmed
//
//  Created by Ricardo dos Santos Amaral on 24/12/23.
//

import Foundation

struct Appointment: Identifiable, Codable {
    let id: String
    let date: String
    let specialist: Specialist
    
    enum CodingKeys: String, CodingKey {
        case id
        case date = "data"
        case specialist = "especialista"
    }
}
