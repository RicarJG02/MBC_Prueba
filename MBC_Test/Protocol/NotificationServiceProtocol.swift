//
//  NotificationServiceProtocol.swift
//  MBC_Test
//
//  Created by Ricardo Guerrero Godínez on 9/11/23.
//

import Foundation

protocol NotificationServiceProtocol {
    func requestAuthorization(completion: @escaping (Bool, Error?) -> Void)
    func scheduleNotification(title: String, body: String)
}
