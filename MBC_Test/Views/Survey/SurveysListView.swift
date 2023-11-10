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
            Image("image1")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            // MARK: Observacion de implementación
            
            // Esto seria para tener la imagen en la pantalla completa y no hardcoded
            // pero ya que la imagenes son mas anchas que altas afectan la vista
            // se puede conseguir el look del figma pero llevaria mucho debug por cuestiones
            // de tiempo tomé la decision de meterlo en surveyCardView.
            
            // Igualmente esta implementado en SurveyDetailScreen.
            
            //            if !viewModel.surveys.isEmpty, viewModel.surveys.indices.contains(selectedCard),
            //               let urlString = viewModel.surveys[selectedCard].attributes.cover_image_url,
            //               let url = URL(string: urlString) {
            //                AsyncImage(url: url) { image in
            //                    image
            //                        .resizable()
            //                        .scaledToFill()
            //                        .edgesIgnoringSafeArea(.all)
            //                } placeholder: {
            //                    ProgressView()
            //                }
            //            } else {
            //                Color.black.edgesIgnoringSafeArea(.all)
            //            }
            
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
                                    SurveyCardView(selectedCard: $selectedCard, survey: survey, index: index, totalSurveys: viewModel.surveys.count)
                                        .frame(width: UIScreen.main.bounds.width)
                                }
                            }
                        }
                    }
                    // Si hace el refresh pero solo lo hace vertical ya que es nativo.
                    // Se puede realizar un gesto personalizado, detectando la posición
                    // de desplazamiento y con eso una actualización.
                    .refreshable {
                        await refreshData()
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
    
    @MainActor
    func refreshData() async {
        isRefreshing = true
        await viewModel.loadSurveys()
        isRefreshing = false
    }
}
