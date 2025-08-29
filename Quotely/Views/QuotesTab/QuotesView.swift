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
    @State private var quoteError: QuoteError?
    
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
                    if isLoading {
                        ProgressView()
                        Text("Quotes are loading...")
                    } else if let error = quoteError {
                        ErrorCardView(error: error)
                    } else if let quote = fetchedQuote {
                        QuoteCard(fetchedQuote: quote)
                    } else {
                        Text("No data loaded yet.")
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
    
    private func fetchQuote() async {
        guard !isLoading else { return }
        isLoading = true
        defer { isLoading = false }
        
        do {
            let quotes: [Quote] = try await NetworkService.sendData(
                to: URLs.quotes,
                responseType: [Quote].self
            )
            
            if let randomQuote = quotes.randomElement() {
                fetchedQuote = randomQuote
                quoteError = nil
            } else {
                fetchedQuote = nil
                quoteError = QuoteError(reason: "No quotes found...")
            }
        } catch let error as QuoteError {
            fetchedQuote = nil
            quoteError = QuoteError(reason: error.errorDescription ?? "Unknown HTTP error")
        } catch {
            fetchedQuote = nil
            quoteError = QuoteError(reason: error.localizedDescription)
        }
    }
    
    // Former methods to fetch Data
    
//    private func getQuoteFromAPI() async throws -> Quote? {
//        let urlString = "https://si-classroom-batch-027.github.io/quotes/quotes.json"
//        
//        guard let url = URL(string: urlString) else {
//            throw QuoteError(reason: "Invalid URL")
//        }
//        
//        let (data, _) = try await URLSession.shared.data(from: url)
//        let result = try JSONDecoder().decode([Quote].self, from: data)
//        
//        guard let random = result.randomElement() else {
//            throw QuoteError(reason: "No posts found...")
//        }
//        
//        return random
//    }
    
//    private func fetchQuote() async {
//        guard !isLoading else { return }
//        isLoading = true
//        defer { isLoading = false }
//        
//        do {
//            fetchedQuote = try await getQuoteFromAPI()
//            quoteError = nil
//        } catch let error as QuoteError {
//            fetchedQuote = nil
//            quoteError = error
//        } catch {
//            fetchedQuote = nil
//            quoteError = QuoteError(reason: error.localizedDescription)
//        }
//    }
}

//#Preview {
//    QuotesView()
//}
