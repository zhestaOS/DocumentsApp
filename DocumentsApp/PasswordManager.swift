//
//  PasswordManager.swift
//  DocumentsApp
//
//  Created by Евгения Шевякова on 13.09.2023.
//

import Foundation
import KeychainSwift

class PasswordManager {
    let passwordKey = "passwordKey"
    
    func save(_ password: String) {
        KeychainSwift().set(password, forKey: passwordKey)
    }
    
    func isPasswordSaved() -> Bool {
        KeychainSwift().get(passwordKey) != nil
    }
    
    func isPasswordCorrect(_ password: String) -> Bool {
        guard let savedPassword = KeychainSwift().get(passwordKey) else {
            return false
        }
        return savedPassword == password
    }
    
    func remove() {
        KeychainSwift().delete(passwordKey)
    }
}
