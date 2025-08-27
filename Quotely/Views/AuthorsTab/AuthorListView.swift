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
                    if !authors.isEmpty {
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
                    } else {
                        ProgressView()
                    }
                }
                .navigationTitle("Authors")
            }
            .task {
                await fetchAuthors()
            }
        }
    }
    
    private func getAuthorsFromAPI() async throws -> [Author] {
        let urlString = "https://si-classroom-batch-027.github.io/quotes/authors.json"
        
        guard let url = URL(string: urlString) else {
            throw HTTPError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let result = try JSONDecoder().decode([Author].self, from: data)
        return result
    }
    
    private func fetchAuthors() async {
        guard !isLoading else { return }
        isLoading = true
        defer { isLoading = false }
        
        do {
            let tempAuthors = try await getAuthorsFromAPI()
            authors = tempAuthors
        } catch let error as HTTPError {
            print(error.rawValue)
        } catch {
            print(error)
        }
    }
}

#Preview {
    AuthorListView()
}
