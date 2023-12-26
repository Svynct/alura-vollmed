//
//  AuthenticationManager.swift
//  Vollmed
//
//  Created by Ricardo dos Santos Amaral on 26/12/23.
//

import Foundation

let tokenKey = "app-vollmed-token"
let patientIDKey = "app-vollmed-patient-id"

class AuthenticationManager: ObservableObject {
    
    static let shared = AuthenticationManager()
    
    @Published var token: String?
    @Published var patientID: String?
    
    private init() {
        self.token = KeychainHelper.get(for: tokenKey)
        self.patientID = KeychainHelper.get(for: patientIDKey)
    }
    
    func saveToken(_ token: String) {
        KeychainHelper.save(value: token, key: tokenKey)
        DispatchQueue.main.async {
            self.token = token
        }
    }
    
    func removeToken() {
        KeychainHelper.remove(for: tokenKey)
        DispatchQueue.main.async {
            self.token = nil
        }
    }
    
    func savePatientID(_ id: String) {
        KeychainHelper.save(value: id, key: patientIDKey)
        DispatchQueue.main.async {
            self.patientID = id
        }
    }
    
    func removePatientID() {
        KeychainHelper.remove(for: patientIDKey)
        DispatchQueue.main.async {
            self.patientID = nil            
        }
    }
}
