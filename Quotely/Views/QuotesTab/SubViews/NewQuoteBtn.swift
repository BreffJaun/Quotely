//
//  NewQuoteBtn.swift
//  Quotely
//
//  Created by Jeff Braun on 25.08.25.
//

import SwiftUI

struct NewQuoteBtn: View {
    var body: some View {
        Button {
            // LATER
        } label: {
            HStack(alignment: .center) {
                Image(systemName: "arrow.clockwise")
                Text("New Quote")
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 20)
        .background(Color.syntaxYellow)
        .clipShape(.capsule)
        .buttonStyle(.plain)
        
    }
}

//#Preview {
//    NewQuoteBtn()
//}
