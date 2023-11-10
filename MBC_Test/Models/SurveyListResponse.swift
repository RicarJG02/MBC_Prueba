//
//  SurveyListResponse.swift
//  MBC_Test
//
//  Created by Ricardo Guerrero Godínez on 9/11/23.
//

import Foundation

struct SurveyListResponse: Decodable {
    var data: [Survey]
    var meta: Meta
}
