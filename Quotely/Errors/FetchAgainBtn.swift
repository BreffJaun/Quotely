//
//  FetchAgainBtn.swift
//  Quotely
//
//  Created by Jeff Braun on 28.08.25.
//

import SwiftUI


struct FetchAgainBtn<E: LocalizedError>: View {
    
    var labelText: String
    var action: () -> Void
    @Binding var errorMessage: E?
    
    var body: some View {
        Button {
            errorMessage = nil
            action()
        } label: {
            HStack(alignment: .center) {
                Image(systemName: "arrow.clockwise")
                Text(labelText)
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 20)
        .background(
            Capsule()
                .fill(Color.syntaxYellow)
                .stroke(Color.secondary.opacity(0.25), lineWidth: 1)
        )
        .clipShape(.capsule)
        .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
        .buttonStyle(.plain)
        
    }
}

//#Preview {
//    FetchAgainBtn()
//}
