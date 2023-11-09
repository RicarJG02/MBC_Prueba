//
//  PasswordResetServiceProtocol.swift
//  MBC_Test
//
//  Created by Ricardo Guerrero Godínez on 9/11/23.
//

import Foundation

protocol PasswordResetServiceProtocol {
    func resetPassword(for email: String, completion: @escaping (Result<Void, Error>) -> Void)
}
