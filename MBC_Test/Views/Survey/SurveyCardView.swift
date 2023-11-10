//
//  SurveyCardView.swift
//  MBC_Test
//
//  Created by Ricardo Guerrero Godínez on 9/11/23.
//

import SwiftUI

struct SurveyCardView: View {
    
    @Binding var selectedCard: Int
    
    let survey: Survey
    var index: Int
    var totalSurveys: Int
    
    // MARK: - View
    var body: some View {
        VStack(alignment: .leading) {
            // Navigation bullets
            HStack(spacing: 8) {
                ForEach(0..<totalSurveys, id: \.self) { surveyIndex in
                    Circle()
                        .frame(width: 10, height: 10)
                        .foregroundColor(surveyIndex == selectedCard ? .white : .gray)
                }
            }
            .padding(.top, 8)
            
            // AsyncImage para cargar la imagen desde la URL
            AsyncImage(url: URL(string: survey.attributes.cover_image_url)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 320, height: 180)
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.white, lineWidth: 4))
            } placeholder: {
                ProgressView()
            }
            .padding(.bottom, 16)

            Text(survey.attributes.title)
                .font(.system(size: 28))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .lineLimit(2)
                .padding(.bottom, 16)
            
            HStack(alignment: .top) {
                Text(survey.attributes.description)
                    .font(.system(size: 17))
                    .foregroundColor(.gray)
                    .lineLimit(2)
                
                Spacer()
                
                Image(systemName: "chevron.forward.circle.fill")
                    .font(.system(size: 40))
                    .foregroundColor(.white)
            }
        }
        .frame(width: 320, alignment: .leading)
//        .background(Color.black.opacity(0.7))
//        .cornerRadius(10)
        .onAppear {
            if index == selectedCard {
                selectedCard += 1
            }
        }
    }
}
