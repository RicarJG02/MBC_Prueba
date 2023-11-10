//
//  SurveyDetailScreen.swift
//  MBC_Test
//
//  Created by Ricardo Guerrero Godínez on 9/11/23.
//

import SwiftUI

struct SurveyDetailScreen: View {
    
    let survey: Survey
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 20) {
                Text("1/5")
                    .foregroundColor(.white)
                    .opacity(0.7)
                Text(survey.attributes.survey_type)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Spacer()
                
                VStack(alignment: .center, spacing: 20) {
                    Text("Very fulfilled")
                        .foregroundColor(.white)
                        .opacity(0.7)
                    Divider()
                    Text("Somewhat fulfilled")
                        .foregroundColor(.white)
                    Divider()
                    Text("Somewhat unfulfilled")
                        .foregroundColor(.white)
                        .opacity(0.7)
                }
                
                Spacer()
                
                HStack {
                    Spacer()
                    Button(action: {
                        // Action for next button
                    }) {
                        Image(systemName: "chevron.forward.circle.fill")
                            .font(.system(size: 40))
                            .foregroundColor(.white)
                    }
                    .padding()
                }
            }
            .padding()
        }
        .navigationBarItems(trailing: Button(action: {
            // Action to close the survey
        }) {
            Image(systemName: "xmark")
                .foregroundColor(.white)
        })
    }
}
