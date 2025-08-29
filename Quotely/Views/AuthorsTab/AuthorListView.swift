//
//  AuthorsView.swift
//  Quotely
//
//  Created by Jeff Braun on 25.08.25.
//

import SwiftUI

struct AuthorListView: View {
    
    @State private var isLoading = false
    @State var authors: [Author] = []
    @State private var authorsError: AuthorsError?
    
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
                        Text("Authors are loading...")
                    } else if let error = authorsError {
                        VStack(spacing: 16) {
                            ErrorCardView(error: error)
                            FetchAgainBtn(
                                labelText: "Fetch Authors again",
                                action: { Task { await fetchAuthors() } },
                                errorMessage: $authorsError
                            )
                        }
                    } else if !authors.isEmpty {
                        List {
                            ForEach(authors) { author in
                                NavigationLink {
                                    AuthorDetailView(author: author)
                                } label: {
                                    Text(author.name)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .scrollContentBackground(.hidden)
                        .background(.clear)
                        .shadow(color: .black.opacity(0.2), radius: 4, x: 2, y: 2)
                    } else {
                        Text("No data loaded yet.")
                    }
                }
                .navigationTitle("Authors")
            }
            .task {
                await fetchAuthors()
            }
        }
    }
    
    private func fetchAuthors() async {
        guard !isLoading else { return }
        isLoading = true
        defer { isLoading = false }
        
        do {
            authors = try await NetworkService.sendData(
                to: URLs.authors,
                responseType: [Author].self
            )
            authorsError = nil
        } catch let error as HTTPError {
            authors = []
            authorsError = AuthorsError(reason: error.errorDescription ?? "Unknown HTTP error")
        } catch {
            authors = []
            authorsError = AuthorsError(reason: error.localizedDescription)
        }
    }
}

#Preview {
    AuthorListView()
}
