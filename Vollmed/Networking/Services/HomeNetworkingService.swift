//
//  HomeNetworkingService.swift
//  Vollmed
//
//  Created by Ricardo dos Santos Amaral on 27/12/23.
//

import Foundation

protocol HomeServiceable {
    func getAllSpecialists() async throws -> Result<[Specialist]?, RequestError>
}

struct HomeNetworkingService: HTTPClient, HomeServiceable {
    func getAllSpecialists() async throws -> Result<[Specialist]?, RequestError> {
        return await sendRequest(endpoint: HomeEndpoint.getAllSpecialists, responseModel: [Specialist].self)
    }
}
