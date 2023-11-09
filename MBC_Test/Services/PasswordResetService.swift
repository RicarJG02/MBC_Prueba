//
//  PasswordResetService.swift
//  MBC_Test
//
//  Created by Ricardo Guerrero Godínez on 9/11/23.
//

import Foundation

class PasswordResetService: PasswordResetServiceProtocol {
    let baseUrl: String
    let clientId: String
    let clientSecret: String

    init(baseUrl: String, clientId: String, clientSecret: String) {
        self.baseUrl = baseUrl
        self.clientId = clientId
        self.clientSecret = clientSecret
    }

    func resetPassword(for email: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: "\(baseUrl)/api/v1/passwords") else {
            completion(.failure(PasswordResetError.invalidURL))
            return
        }
        
        let parameters: [String: Any] = [
            "user": ["email": email],
            "client_id": clientId,
            "client_secret": clientSecret
        ]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        do {
            let postData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            request.httpBody = postData
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        } catch {
            completion(.failure(PasswordResetError.serializationError))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data, let responseString = String(data: data, encoding: .utf8),
                  !responseString.contains("invalid_client") else {
                completion(.failure(PasswordResetError.invalidClientOrErrorInResponse))
                return
            }

            completion(.success(()))
        }
        .resume()
    }
}

enum PasswordResetError: Error {
    case invalidURL
    case serializationError
    case invalidClientOrErrorInResponse
}
