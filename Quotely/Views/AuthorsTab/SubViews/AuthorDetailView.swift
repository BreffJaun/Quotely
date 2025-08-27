//
//  AuthorDetailView.swift
//  Quotely
//
//  Created by Jeff Braun on 27.08.25.
//

import SwiftUI

struct AuthorDetailView: View {
    
    var author: Author
    @State private var isLoading = false
    @State private var authorQuotes: [Quote] = []
    
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
                if !authorQuotes.isEmpty {
                    List {
                        ForEach(authorQuotes) { quote in
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
                } else {
                    ProgressView()
                }
            }
            .task {
                await fetchAuthorQuotes()
            }
        }
    }
    
    private func getAuthorQuotesFromAPI() async throws -> [Quote] {
        let urlString = "https://si-classroom-batch-027.github.io/quotes/quotes/\(author.slug).json"
        
        guard let url = URL(string: urlString) else {
            throw HTTPError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let result = try JSONDecoder().decode([Quote].self, from: data)
        return result
    }
    
    private func fetchAuthorQuotes() async {
        guard !isLoading else { return }
        isLoading = true
        defer { isLoading = false }
        
        do {
            let tempAuthorQuotes = try await getAuthorQuotesFromAPI()
            authorQuotes = tempAuthorQuotes
        } catch let error as HTTPError {
            print(error.rawValue)
        } catch {
            print(error)
        }
    }
}

//#Preview {
//    AuthorDetailView()
//}
