//
//  ForgotPasswordViewModel.swift
//  MBC_Test
//
//  Created by Ricardo Guerrero Godínez on 9/11/23.
//

import Foundation

class ForgotPasswordViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var showAlert: Bool = false
    @Published var errorMessage: String = ""
    @Published var shouldDismiss: Bool = false

    private var passwordResetService: PasswordResetServiceProtocol
    private var notificationManager: NotificationServiceProtocol

    init(passwordResetService: PasswordResetServiceProtocol, notificationManager: NotificationServiceProtocol) {
        self.passwordResetService = passwordResetService
        self.notificationManager = notificationManager
    }

    func performPasswordRecovery() {
        guard !email.isEmpty else {
            showAlert = true
            errorMessage = "Email cannot be empty."
            return
        }

        passwordResetService.resetPassword(for: email) { [weak self] result in
            switch result {
            case .success:
                self?.notificationManager.requestAuthorization { granted, _ in
                    if granted {
                        self?.notificationManager.scheduleNotification(title: "Great!", body: "Follow the instructions to reset your password.")
                        DispatchQueue.main.async {
                            self?.shouldDismiss = true
                        }
                    } else {
                        DispatchQueue.main.async {
                            self?.errorMessage = "Notification permission was not granted."
                            self?.showAlert = true
                        }
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.errorMessage = error.localizedDescription
                    self?.showAlert = true
                }
            }
        }
    }
}
