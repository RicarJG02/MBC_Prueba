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

    init() {}

    func saveAccessToken(token: String, validDuration: Int, renewalToken: String) {
        let defaults = UserDefaults.standard
        defaults.set(token, forKey: "TokenAccessKey")
        defaults.set(validDuration, forKey: "TokenValidityKey")
        defaults.set(renewalToken, forKey: "TokenRenewalKey")
    }
}
