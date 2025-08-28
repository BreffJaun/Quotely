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
    
    
    private func getCategoriesFromAPI() async throws -> [String] {
        let urlString = "https://si-classroom-batch-027.github.io/quotes/categories.json"
        guard let url = URL(string: urlString) else {
            throw CategoriesError(reason: "Invalid URL")
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let result = try JSONDecoder().decode([String].self, from: data)
        
        if result.isEmpty {
            throw CategoriesError(reason: "No categories found...")
        }
        
        return result
    }
    
    private func fetchCategories() async {
        guard !isLoading else { return }
        isLoading = true
        defer { isLoading = false }
        
        do {
            apiCategories = try await getCategoriesFromAPI()
            displayedCategories = apiCategories.map { categoryMapping[$0.lowercased()] ?? $0.capitalized }
            categoriesError = nil
        } catch let error as CategoriesError {
            apiCategories = []
            displayedCategories = []
            categoriesError = error
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

