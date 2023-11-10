//
//  LogInView.swift
//  MBC_Test
//
//  Created by Ricardo Guerrero Godínez on 9/11/23.
//

import SwiftUI

struct LogInView: View {
    @ObservedObject private var viewModel = LogInViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("background").resizable()
                VStack(spacing: 20) {
                    Image("logo").resizable().frame(width: 160, height: 40).padding(.bottom, 80)
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundStyle(.gray.opacity(0.3))
                        
                        TextField("", text: $viewModel.email, prompt: Text("Email")
                            .foregroundColor(Color.gray))
                        .keyboardType(.emailAddress)
                        .submitLabel(.next)
                        .foregroundStyle(.white)
                        .padding(.horizontal)
                    }
                    .frame(height: 40)
                    .padding(.horizontal)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundStyle(.gray.opacity(0.3))
                        
                        HStack {
                            SecureField("", text: $viewModel.password, prompt: Text("Password").foregroundColor(Color.gray))
                                .foregroundStyle(.white)
                                .padding(.horizontal)
                            
                            
                            Button {
                                viewModel.isRecoverPresented.toggle()
                            } label: {
                                Text("Forgot?")
                                    .font(.callout)
                                    .foregroundColor(.gray.opacity(0.8))
                            }
                            .padding(.horizontal)
                        }
                    }
                    .frame(height: 40)
                    .padding(.horizontal)
                    
                    Button {
                        viewModel.performAuthentication()
                    } label: {
                        Text("Log in").bold().frame(maxWidth: .infinity).frame(height: 36)
                    }
                    .foregroundColor(.black)
                    .accentColor(.white)
                    .buttonStyle(.borderedProminent)
                    .padding()
                    
                    NavigationLink(destination: SurveysListView(viewModel: SurveysListViewModel()), isActive: $viewModel.isSurveyListPresented) {
                        EmptyView()
                    }
                    NavigationLink(destination: ForgotPasswordView(), isActive: $viewModel.isRecoverPresented) {
                        EmptyView()
                    }
                }
                .alert(isPresented: $viewModel.showAlert) {
                    Alert(
                        title: Text("Error"),
                        message: Text(viewModel.errorMessage),
                        dismissButton: .default(Text("OK"))
                    )
                }
                .padding()
            }
            .ignoresSafeArea()
            .navigationBarHidden(true)
        }
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
