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
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.systemBackground))
        }
        .task {
            await fetchQuote()
        }
    }
    
    private func getQuoteFromAPI() async throws -> Quote? {
        let urlString = "https://si-classroom-batch-027.github.io/quotes/quotes.json"
        
        guard let url = URL(string: urlString) else {
            throw HTTPError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let result = try JSONDecoder().decode([Quote].self, from: data)
//        print("===========")
//        print(result.randomElement())
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

//struct QuotesView: View {
//    
//    @State private var quote: Quote? = nil
//    
//    
//    var body: some View {
//        ZStack {
//            LinearGradient(
//                colors: [
//                    Color("syntaxPurple"),
//                    Color("syntaxGrey"),
//                    Color("syntaxYellow")
//                ],
//                startPoint: .topLeading,
//                endPoint: .bottomTrailing
//            )
//            .ignoresSafeArea()
//            VStack {
//                if let fetchQuote = quote {
//                    VStack(alignment: .leading, spacing: 8) {
//                        Text(fetchQuote.text)
//                            .font(.headline)
//                        Text("- \(fetchQuote.author)")
//                            .font(.subheadline)
//                            .foregroundColor(.secondary)
//                    }
//                    .padding()
//                } else {
//                    ProgressView()
//                }
//            }
//            .task {
//                await fetchQuote()
//            }
//        }
//    }
//    func getQuoteFromAPI() async throws -> Quote? {
//        let urlString = "https://si-classroom-batch-027.github.io/quotes/quotes.json"
//        
//        guard let url = URL(string: urlString) else {
//            throw HTTPError.invalidURL
//        }
//        
//        let (data, _) = try await URLSession.shared.data(from: url)
//        let result = try JSONDecoder().decode([Quote].self, from: data)
//        return result.randomElement()
//    }
//    func fetchQuote() async {
//        //            Task {
//        do {
//            if let tempQuote = try await getQuoteFromAPI() {
//                quote = tempQuote
//                print(quote ?? "Kein Quote erhalten")
//            }
//        } catch {
//            print("Fehler beim Laden: \(error)")
//        }
//        //}
//    }
//}

//#Preview {
//    QuotesView()
//}
