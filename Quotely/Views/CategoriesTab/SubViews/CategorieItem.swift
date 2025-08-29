//
//  CategorieItem.swift
//  Quotely
//
//  Created by Jeff Braun on 26.08.25.
//

import SwiftUI

struct CategorieItem: View {
    
    var cat: String
    
    var body: some View {
        Text(cat.capitalized)
            .font(.title2)
            .frame(width: 180, height: 80)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.syntaxYellow)
                    .stroke(Color.secondary.opacity(0.25), lineWidth: 1)
            )
            .padding(8)
            .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
    }
}

//#Preview {
//    CategorieItem()
//}
