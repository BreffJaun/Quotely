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
            )
            .padding(8)
            
    }
}

//#Preview {
//    CategorieItem()
//}
