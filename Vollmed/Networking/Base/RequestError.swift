//
//  RequestError.swift
//  Vollmed
//
//  Created by Ricardo dos Santos Amaral on 27/12/23.
//

import Foundation

enum RequestError: Error {
    case decode
    case invalidURL
    case noResponse
    case unauthorized
    case unkown
    case custom(_ error: [String: Any])
    
    var customMessage: String {
        switch self {
        case .decode:
            return "Erro de decodificação"
        case .unauthorized:
            return "Sessão expirada"
        default:
            return "Erro desconhecido"
        }
    }
}
