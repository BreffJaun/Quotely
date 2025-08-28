//
//  ErrorCardView.swift
//  Quotely
//
//  Created by Jeff Braun on 28.08.25.
//

import SwiftUI

struct ErrorCardView: View {
    
    var error: LocalizedError
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 28))
                .foregroundColor(.red)
                .padding(.top)
            
            Text(error.errorDescription ?? "Unknown error")
                .font(.system(size: 20))
                .fontWeight(.semibold)
                .foregroundColor(.red)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 16)
                .frame(maxWidth: 250)
            
            if let suggestion = error.recoverySuggestion {
                Text(suggestion)
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
                    .padding(.bottom)
            }
        }
        .frame(maxWidth: .infinity)
        .background(
            Color.white
                .cornerRadius(30)
        )
        .shadow(color: .gray.opacity(0.35), radius: 8, x: 0, y: 4)
        .padding(.horizontal, 30)
    }
}

//#Preview {
//    ErrorCardView()
//}
