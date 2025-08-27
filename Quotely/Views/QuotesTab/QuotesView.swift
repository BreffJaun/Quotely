//
//  HomeView.swift
//  03_W06_Notes
//
//  Created by Jeff Braun on 25.08.25.
//

import SwiftUI

struct QuotesView: View {
    
    @State private var isLoading = false
    @State var fetchedQuote: Quote?
    
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
                VStack(alignment: .center) {
                    Spacer()
                    if let quote = fetchedQuote {
                        QuoteCard(fetchedQuote: quote)
                    } else {
                        ProgressView()
                    }
                    Spacer()
                    NewQuoteBtn {
                        Task {
                            await fetchQuote()
                        }
                    }
                    .padding(.bottom, 16)
                }
            }
            .task {
                await fetchQuote()
            }
        }
    }
    
    private func getQuoteFromAPI() async throws -> Quote? {
        let urlString = "https://si-classroom-batch-027.github.io/quotes/quotes.json"
        
        guard let url = URL(string: urlString) else {
            throw HTTPError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let result = try JSONDecoder().decode([Quote].self, from: data)
        return result.randomElement()
    }
    
    private func fetchQuote() async {
        guard !isLoading else { return }
        isLoading = true
        defer { isLoading = false }
        
        do {
            if let tempQuote = try await getQuoteFromAPI() {
                fetchedQuote = tempQuote
            } else {
                print("No quotes found...")
            }
        } catch let error as HTTPError {
            print(error.rawValue)
        } catch {
            print(error)
        }
    }
}

//#Preview {
//    QuotesView()
//}
