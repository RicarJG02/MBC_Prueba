//
//  LogInView.swift
//  MBC_Test
//
//  Created by Ricardo Guerrero Godínez on 9/11/23.
//

import SwiftUI
import Combine

class LogInViewModel: ObservableObject {
    private var authService: AuthenticationServiceProtocol
    var tokenManager = TokenStorageManager()

    @Published var email: String = ""
    @Published var password: String = ""
    @Published var showAlert: Bool = false
    @Published var errorMessage: String = ""
    @Published var isSurveyListPresented: Bool = false
    @Published var isRecoverPresented: Bool = false

    init(authService: AuthenticationServiceProtocol = AuthenticationService()) {
        self.authService = authService
    }

    func performAuthentication() {
        authService.authenticate(email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let authData):
                    self?.tokenManager.saveAccessToken(token: authData.accessToken,
                                                       validDuration: authData.expiresIn,
                                                       renewalToken: authData.refreshToken)
                    self?.isSurveyListPresented = true
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showAlert = true
                }
            }
        }
    }

    func moveToSurveysScreen() {
        DispatchQueue.main.async {
            self.isSurveyListPresented = true
        }
    }
}
