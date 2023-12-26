//
//  Login.swift
//  Vollmed
//
//  Created by Ricardo dos Santos Amaral on 26/12/23.
//

import Foundation

struct LoginRequest: Codable {
    let email: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case email
        case password = "senha"
    }
}

struct LoginResponse: Codable {
    let auth: Bool
    let id: String
    let token: String
}
