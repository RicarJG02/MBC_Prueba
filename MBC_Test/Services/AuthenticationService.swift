//
//  AuthenticationService.swift
//  MBC_Test
//
//  Created by Ricardo Guerrero Godínez on 9/11/23.
//

import Foundation

struct AuthData {
    var accessToken: String
    var expiresIn: Int
    var refreshToken: String
}

protocol AuthenticationServiceProtocol {
    func authenticate(email: String, password: String, completion: @escaping (Result<AuthData, Error>) -> Void)
}

class AuthenticationService: AuthenticationServiceProtocol {
    let baseUrl = "https://survey-api.nimblehq.co"
    let clientId = "ofzl-2h5ympKa0WqqTzqlVJUiRsxmXQmt5tkgrlWnOE"
    let clientSecret = "lMQb900L-mTeU-FVTCwyhjsfBwRCxwwbCitPob96cuU"

    func authenticate(email: String, password: String, completion: @escaping (Result<AuthData, Error>) -> Void) {
        guard let url = URL(string: "\(baseUrl)/api/v1/oauth/token") else {
            completion(.failure(AuthenticationError.invalidURL))
            return
        }

        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = [
            URLQueryItem(name: "grant_type", value: "password"),
            URLQueryItem(name: "email", value: email),
            URLQueryItem(name: "password", value: password),
            URLQueryItem(name: "client_id", value: clientId),
            URLQueryItem(name: "client_secret", value: clientSecret)
        ]

        guard let requestUrl = components?.url else {
            completion(.failure(AuthenticationError.invalidRequestURL))
            return
        }

        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(.failure(error ?? AuthenticationError.unknownError))
                return
            }

            if let responseString = String(data: data, encoding: .utf8) {
                if let jsonData = responseString.data(using: .utf8),
                   let tokenResponse = try? JSONDecoder().decode(Token.self, from: jsonData) {
                    let accessToken = tokenResponse.data.attributes.access_token
                    let expiresIn = Int(tokenResponse.data.attributes.expires_in)
                    let refreshToken = tokenResponse.data.attributes.refresh_token
                    completion(.success(AuthData(accessToken: accessToken, expiresIn: expiresIn, refreshToken: refreshToken)))
                } else {
                    completion(.failure(AuthenticationError.decodingError))
                }
            }
        }
        .resume()
    }
}

enum AuthenticationError: Error {
    case invalidURL
    case invalidRequestURL
    case unknownError
    case decodingError
}
