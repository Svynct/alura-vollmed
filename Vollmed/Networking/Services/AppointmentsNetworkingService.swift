//
//  AppointmentsService.swift
//  Vollmed
//
//  Created by Ricardo dos Santos Amaral on 27/12/23.
//

import Foundation

protocol AppointmentsNetworkingServiceable {
    func getAllAppointmentsFromPatient() async -> Result<[Appointment]?, RequestError>
}

struct AppointmentsNetworkingService: HTTPClient, AppointmentsNetworkingServiceable {
    func getAllAppointmentsFromPatient() async -> Result<[Appointment]?, RequestError> {
        return await sendRequest(endpoint: AppointmentsEndpoint.getAllAppointments, responseModel: [Appointment].self)
    }
}
