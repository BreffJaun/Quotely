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
    @State private var authorsError: AuthorsError?
    
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
                    Text("Quotes are loading...")
                } else if let error = authorsError {
                    ErrorCardView(error: error)
                } else if !authorQuotes.isEmpty {
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
                    .shadow(color: .black.opacity(0.2), radius: 4, x: 2, y: 2)
                } else {
                    Text("No quotes found for this author.")
                }
            }
            .task {
                await fetchAuthorQuotes()
            }
        }
    }
    
    private func fetchAuthorQuotes() async {
        guard !isLoading else { return }
        isLoading = true
        defer { isLoading = false }
        
        do {
            authorQuotes = try await NetworkService.sendData(
                to: URLs.authorQuotes(slug: author.slug),
                responseType: [Quote].self
            )
            authorsError = nil
        } catch let error as HTTPError {
            authorQuotes = []
            authorsError = AuthorsError(reason: error.errorDescription ?? "Unknown HTTP error")
            print("HTTPError: \(error.errorDescription ?? "Unknown error")")
        } catch {
            authorQuotes = []
            authorsError = AuthorsError(reason: error.localizedDescription)
            print("Unexpected error: \(error.localizedDescription)")
        }
    }
}

//#Preview {
//    AuthorDetailView()
//}
