//
//  Survey.swift
//  MBC_Test
//
//  Created by Ricardo Guerrero Godínez on 9/11/23.
//

import Foundation

struct Survey: Codable, Identifiable {
    
    var id: String
    var type: String
    var attributes: Attributes
    
}
