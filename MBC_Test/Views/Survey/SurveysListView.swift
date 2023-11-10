//
//  SurveysListView.swift
//  MBC_Test
//
//  Created by Ricardo Guerrero Godínez on 9/11/23.
//

import SwiftUI

struct SurveysListView: View {

    @StateObject var viewModel: SurveysListViewModel
        
    @State private var currentDateAndTime = Date.now
    @State private var isRefreshing = false
    @State private var selectedCard = 0
    
    // MARK: - View
    var body: some View {
        ZStack {
            Image(selectedCard % 2 == 0 ? "image2" : "image1")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else {
                    
                    VStack(alignment: .leading) {
                        
                        Text(viewModel.formattedDateString())
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        HStack {
                            Text("Today")
                                .font(.largeTitle)
                                .bold()
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())
                                .padding(.horizontal)
                        }
                    }
                    .padding(.top, 64)
                    .padding()
                    
                    Spacer()
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .bottom, spacing: 0) {
                            ForEach(0..<viewModel.surveys.count, id: \.self) { index in
                                let survey = viewModel.surveys[index]
                                NavigationLink(destination: SurveyDetailScreen(survey: survey)) {
                                    SurveyCardView(selectedCard: $selectedCard, survey: survey, index: index)
                                        .frame(width: UIScreen.main.bounds.width)
                                }
                            }
                        }
                    }
                    .padding()
                    .padding(.bottom, 48)
                }
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            viewModel.loadSurveys()
        }
    }
    
    func refreshData() {
        isRefreshing = true
        viewModel.loadSurveys()
        isRefreshing = false
    }
}
