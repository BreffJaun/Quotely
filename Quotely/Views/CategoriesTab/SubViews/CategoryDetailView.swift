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
    @State private var categoryError: QuoteError?
    
    var body: some View {
        VStack {
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
                if isLoading {
                    ProgressView()
                        .scaleEffect(1.5)
                        .padding()
                } else if fetchedQuotes.isEmpty {
                    Text("No quotes found...")
                        .foregroundColor(.secondary)
                        .padding()
                } else {
                    List {
                        ForEach(fetchedQuotes) { quote in
                            VStack(alignment: .leading, spacing: 8) {
                                Text(quote.text)
                                Text(quote.author)
                                    .font(.footnote)
                                    .italic()
                            }
                            .padding(.vertical, 4)
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .background(.clear)
                    .shadow(color: .black.opacity(0.2), radius: 4, x: 2, y: 2)
                }
            }
            .navigationTitle(cat.capitalized)
            .navigationBarTitleDisplayMode(.inline)
            .task {
                await fetchQuotes()
            }
        }
    }
    
    private func fetchQuotes() async {
        guard !isLoading else { return }
        isLoading = true
        defer { isLoading = false }
        
        do {
            fetchedQuotes = try await NetworkService.sendData(
                to: URLs.specificCat(cat: cat),
                responseType: [Quote].self
            )
            categoryError = nil
        } catch let error as HTTPError {
            fetchedQuotes = []
            categoryError = QuoteError(reason: error.errorDescription ?? "Unknown HTTP error")
        } catch {
            fetchedQuotes = []
            categoryError = QuoteError(reason: error.localizedDescription)
        }
    }
}

//#Preview {
//    CategoryDetailView()
//}
