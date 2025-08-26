//
//  QuoteCard.swift
//  Quotely
//
//  Created by Jeff Braun on 25.08.25.
//

import SwiftUI

struct QuoteCard: View {
    
    var fetchedQuote: Quote
    
    var body: some View {
        VStack(alignment: .center, spacing: 24) {
            Image(systemName: "quote.opening")
                .font(.system(size: 24))
                .foregroundColor(.syntaxPurple)
                .padding(.top)
            Text(fetchedQuote.text)
                .padding(.horizontal, 16)
                .frame(maxWidth: 250)
                .font(.system(size: 24))
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
            Text(fetchedQuote.author)
                .italic()
                .padding(.bottom)
            
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
//    QuoteCard()
//}
