//
//  CategoriesView.swift
//  Quotely
//
//  Created by Jeff Braun on 25.08.25.
//

import SwiftUI

struct CategoriesView: View {
    
    @State private var apiCategories: [String] = []
    @State private var displayedCategories: [String] = []
    @State private var isLoading = false
    @State private var categoriesError: CategoriesError?
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [
                        Color("syntaxPurple"),
                        Color("syntaxGrey"),
                        Color("syntaxYellow")
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                VStack {
                    if isLoading {
                        ProgressView()
                        Text("Categories are loading...")
                    } else if let error = categoriesError {
                        VStack(spacing: 16) {
                            ErrorCardView(error: error)
                            FetchAgainBtn(
                                labelText: "Fetch Categories again",
                                action: { Task { await fetchCategories() } },
                                errorMessage: $categoriesError
                            )
                        }
                    } else if !categories.isEmpty {
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2)) {
                            ForEach(Array(displayedCategories.enumerated()), id: \.offset) { index, displayCat in
                                NavigationLink {
                                    CategoryDetailView(cat: apiCategories[index])
                                } label: {
                                    CategorieItem(cat: displayCat)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.horizontal, 8)
                    } else {
                        Text("No data loaded yet.")
                    }
                }
                Spacer()
            }
            .navigationTitle("Categories")
        }
        .task {
            await fetchCategories()
        }
    }
    
    private func fetchCategories() async {
        guard !isLoading else { return }
        isLoading = true
        defer { isLoading = false }
        
        do {

            apiCategories = try await NetworkService.sendData(
                to: URLs.categories,
                responseType: [String].self
            )
            
            // Mapping for View with German words
            displayedCategories = apiCategories.map { categoryMapping[$0.lowercased()] ?? $0.capitalized }
            
            categoriesError = nil
        } catch let error as HTTPError {
            apiCategories = []
            displayedCategories = []
            categoriesError = CategoriesError(reason: error.errorDescription ?? "Unknown HTTP error")
        } catch {
            apiCategories = []
            displayedCategories = []
            categoriesError = CategoriesError(reason: error.localizedDescription)
        }
    }
}

//#Preview {
//    CategoriesView()
//}

