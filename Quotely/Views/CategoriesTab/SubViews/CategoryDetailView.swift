//
//  CategoryDetailView.swift
//  Quotely
//
//  Created by Jeff Braun on 26.08.25.
//

import SwiftUI

struct CategoryDetailView: View {
    
    var cat: String
    
    @State private var isLoading = false
    @State private var fetchedQuotes: [Quote] = []
    
    var body: some View {
        VStack {
            if isLoading {
                ProgressView()
                    .scaleEffect(1.5)
                    .padding()
            } else if fetchedQuotes.isEmpty {
                Text("No quotes found...")
                    .foregroundColor(.secondary)
                    .padding()
            } else {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(fetchedQuotes) { quote in
                            QuoteCard(fetchedQuote: quote)
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationTitle(cat.capitalized)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await fetchQuotes()
        }
    }
    
    
    private func getQuotesFromAPI() async throws -> [Quote] {
        let urlString = "https://si-classroom-batch-027.github.io/quotes/quotes/\(cat).json"
        
        guard let url = URL(string: urlString) else {
            throw HTTPError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let result = try JSONDecoder().decode([Quote].self, from: data)
        return result
    }
    
    private func fetchQuotes() async {
        guard !isLoading else { return }
        isLoading = true
        defer { isLoading = false }
        
        do {
            let result = try await getQuotesFromAPI()
            fetchedQuotes = result
        } catch let error as HTTPError {
            print(error.rawValue)
        } catch {
            print(error)
        }
    }
}

//#Preview {
//    CategoryDetailView()
//}
