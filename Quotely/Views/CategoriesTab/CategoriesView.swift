//
//  CategoriesView.swift
//  Quotely
//
//  Created by Jeff Braun on 25.08.25.
//

import SwiftUI

struct CategoriesView: View {
    var body: some View {
        NavigationStack {
            VStack {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2 )) {
                    ForEach(gridCategories, id: \.self) { row in
                        ForEach(row, id:\.self) { cat in
                            Text(cat.rawValue)
                                .font(.title2)
                                .frame(width: 180, height: 80)
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(Color.syntaxYellow)
                                )
                                .padding(8)
                        }
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 8)
            .navigationTitle("Categories")
        }        
    }
}

//#Preview {
//    CategoriesView()
//}


//enum Category: String, Codable {
//    case motivation = "motivation"
//    case life = "life"
//    case love = "love"
//    case wisdom = "wisdom"
//    case success = "success"
//    case happiness = "happiness"
//    case courage = "courage"
//    case friendship = "friendship"
//    case education = "education"
//    case future = "future"
//}
