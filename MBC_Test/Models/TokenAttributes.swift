//
//  TokenAttributes.swift
//  MBC_Test
//
//  Created by Ricardo Guerrero Godínez on 9/11/23.
//

import Foundation

struct TokenAttributes: Codable {
    
    let access_token: String
    let token_type: String
    let expires_in: Int
    let refresh_token: String
    let created_at: Int
    
}
