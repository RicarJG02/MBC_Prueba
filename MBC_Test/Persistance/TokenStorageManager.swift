//
//  TokenStorageManager.swift
//  MBC_Test
//
//  Created by Ricardo Guerrero Godínez on 9/11/23.
//

import Foundation

class TokenStorageManager {
    static let shared = TokenStorageManager()
    
    private enum Keys {
        static let accessToken = "AccessToken"
        static let expiresIn = "ExpiresIn"
        static let refreshToken = "RefreshToken"
    }

    func saveAccessToken(token: String, validDuration: Int, renewalToken: String) {
        let defaults = UserDefaults.standard
        defaults.set(token, forKey: Keys.accessToken)
        defaults.set(validDuration, forKey: Keys.expiresIn)
        defaults.set(renewalToken, forKey: Keys.refreshToken)
    }

    func getAccessToken() -> String? {
        let defaults = UserDefaults.standard
        return defaults.string(forKey: Keys.accessToken)
    }

    func getExpiresIn() -> Int {
        let defaults = UserDefaults.standard
        return defaults.integer(forKey: Keys.expiresIn)
    }

    func getRefreshToken() -> String? {
        let defaults = UserDefaults.standard
        return defaults.string(forKey: Keys.refreshToken)
    }
}
