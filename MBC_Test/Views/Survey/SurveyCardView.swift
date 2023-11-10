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
    
    // MARK: - View
    var body: some View {
        VStack(alignment: .leading) {
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
                    .tint(.white)
            }
        }
        .frame(width: 320)
        .onAppear {
            if index == selectedCard {
                selectedCard += 1
            }
        }
    }
}
