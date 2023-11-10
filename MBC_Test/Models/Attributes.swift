//
//  Attributes.swift
//  MBC_Test
//
//  Created by Ricardo Guerrero Godínez on 9/11/23.
//

import Foundation

struct Attributes: Codable {
    
    var title: String
    var description: String
    var thank_email_above_threshold: String
    var thank_email_below_threshold: String
    var is_active: Bool
    var cover_image_url: String
    var created_at: String
    var active_at: String
    var inactive_at: String?
    var survey_type: String
    
}
