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
    case custom(error: [String: Any]?)
    
    var customMessage: String {
        switch self {
        case .decode:
            return "Erro de decodificação"
        case .unauthorized:
            return "Sessão expirada"
        case .custom(let errorData):
            if let jsonError = errorData?["error"] as? [String: Any] {
                let message = jsonError["message"] as? String ?? ""
                return message
            }
            return "Ops! Ocorreu um erro ao carregar as informações"
        default:
            return "Erro desconhecido"
        }
    }
}
