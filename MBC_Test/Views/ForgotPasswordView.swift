//
//  ForgotPasswordView.swift
//  MBC_Test
//
//  Created by Ricardo Guerrero Godínez on 9/11/23.
//

import SwiftUI

struct ForgotPasswordView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: ForgotPasswordViewModel
    
    init() {
        let service = AuthenticationService()
        let passwordService = PasswordResetService(baseUrl: service.baseUrl, clientId: service.clientId, clientSecret: service.clientSecret)
        let notificationService = NotificationService()
        
        _viewModel = StateObject(wrappedValue: ForgotPasswordViewModel(passwordResetService: passwordService, notificationManager: notificationService))
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("background")
                    .resizable()
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    Image("logo")
                        .resizable()
                        .frame(width: 160, height: 40)
                    
                    Text("Enter your email to receive instructions for resetting your password.")
                        .foregroundStyle(.gray)
                        .padding(.bottom, 120)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.gray.opacity(0.3))
                        
                        TextField("Email", text: $viewModel.email)
                            .keyboardType(.emailAddress)
                            .foregroundColor(.white)
                            .padding()
                    }
                    .frame(height: 40)
                    .padding(.horizontal)
                    
                    Button(action: viewModel.performPasswordRecovery) {
                        Text("Reset")
                            .bold()
                            .frame(maxWidth: .infinity)
                            .frame(height: 36)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding()
                    .disabled(viewModel.email.isEmpty)
                }
                .padding()
                .alert(isPresented: $viewModel.showAlert) {
                    Alert(
                        title: Text("Error"),
                        message: Text(viewModel.errorMessage),
                        dismissButton: .default(Text("OK"))
                    )
                }
            }
            .navigationBarHidden(true)
        }
        .onReceive(viewModel.$shouldDismiss) { shouldDismiss in
            if shouldDismiss {
                dismiss()
            }
        }
    }
}
