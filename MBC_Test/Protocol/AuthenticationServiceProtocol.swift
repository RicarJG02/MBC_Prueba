//
//  AuthenticationServiceProtocol.swift
//  MBC_Test
//
//  Created by Ricardo Guerrero Godínez on 9/11/23.
//

import Foundation

protocol AuthenticationServiceProtocol {
    func authenticate(email: String, password: String, completion: @escaping (Result<AuthData, Error>) -> Void)
}
