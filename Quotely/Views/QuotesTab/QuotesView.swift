//
//  HomeView.swift
//  03_W06_Notes
//
//  Created by Jeff Braun on 25.08.25.
//

import SwiftUI

struct QuotesView: View {
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                Spacer()
                QuoteCard()
                Spacer()
                NewQuoteBtn()
                    .padding(.bottom, 16)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.systemBackground))
        }        
    }
}

//#Preview {
//    QuotesView()
//}
