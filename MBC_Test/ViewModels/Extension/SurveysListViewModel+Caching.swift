//
//  SurveysListViewModel+Caching.swift
//  MBC_Test
//
//  Created by Ricardo Guerrero Godínez on 10/11/23.
//

import Foundation

extension SurveysListViewModel {
    
    // Key for saving surveys to UserDefaults
    private var surveysCacheKey: String {
        "surveysCacheKey"
    }
    
    // Function to save survey data to UserDefaults
    func cacheSurveys() {
        do {
            let data = try JSONEncoder().encode(surveys)
            UserDefaults.standard.set(data, forKey: surveysCacheKey)
            print("Surveys cached successfully.")
        } catch {
            print("Failed to cache surveys: \(error)")
        }
    }
    
    // Function to load cached survey data from UserDefaults
    func loadCachedSurveys() {
        guard let data = UserDefaults.standard.data(forKey: surveysCacheKey) else {
            print("No cached data available.")
            return
        }
        
        do {
            surveys = try JSONDecoder().decode([Survey].self, from: data)
            print("Cached surveys loaded successfully.")
        } catch {
            print("Failed to load cached surveys: \(error)")
        }
    }
    
    func loadSurveysUsingCache() {
        isLoading = true
        
        // First attempt to load cached data
        loadCachedSurveys()
        
        // Then attempt to refresh data from the server
        let urlString = "\(authService.baseUrl)/api/v1/surveys?page[number]=1&page[size]=2"
        print("Loading surveys from server...")
        loadData(with: urlString)
    }
}
