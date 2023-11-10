//
//  SurveysListViewModel.swift
//  MBC_Test
//
//  Created by Ricardo Guerrero Godínez on 9/11/23.
//

import Foundation
import SwiftUI

class SurveysListViewModel: ObservableObject {
    @Published var surveys: [Survey] = []
    @Published var isLoading: Bool = false
    var authService = AuthenticationService()

    func loadSurveys() {
        isLoading = true
        let urlString = "\(authService.baseUrl)/api/v1/surveys?page[number]=1&page[size]=2"
        print("Iniciando la carga de encuestas...")
        loadData(with: urlString)
    }

    func loadData(with urlString: String) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            isLoading = false
            return
        }

        guard let accessToken = TokenStorageManager.shared.getAccessToken() else {
            print("Access token not saved")
            refreshToken()
            return
        }

        var request = URLRequest(url: url)
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                guard let data = data else {
                    print("Error: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }

                let responseString = String(decoding: data, as: UTF8.self)
                print("Response JSON as string: \(responseString)")

                if responseString.contains("invalid_token") {
                    self?.refreshToken()
                } else {
                    self?.decodeSurveyData(data)
                }
            }
        }.resume()
    }

    private func decodeSurveyData(_ data: Data) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)

        do {
            let decodedData = try decoder.decode(SurveyListResponse.self, from: data)
            surveys = decodedData.data
            print("Decoding successful, \(surveys.count) surveys loaded.")
            cacheSurveys()
        } catch {
            print("Error decoding JSON: \(error)")
        }
    }

    func refreshToken() {
        print("Attempting to refresh token...")
        loadSurveys()
    }

    func formattedDateString() -> String {
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, dd MMMM"
        return formatter.string(from: currentDate).uppercased()
    }
}
