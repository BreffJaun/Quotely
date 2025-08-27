//
//  ContentView.swift
//  03_W06_Notes
//
//  Created by Jeff Braun on 25.08.25.
//

import SwiftUI
import SwiftData
import UIKit

struct TabBarView: View {
    var body: some View {
        TabView {
            Tab("Quote", systemImage: "quote.closing") {
                QuotesView()
            }
            
            Tab("Authors", systemImage: "person.crop.artframe") {
                AuthorListView()
            }
            
            Tab("Categories", systemImage: "square.grid.2x2.fill") {
                CategoriesView()
            }
            
            Tab("Inspirations", systemImage: "sparkle") {
                InspirationsView()
            }
        }
    }
}

#Preview {
    TabBarView()
}
