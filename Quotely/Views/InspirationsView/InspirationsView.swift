//
//  InspirationsView.swift
//  Quotely
//
//  Created by Jeff Braun on 25.08.25.
//

import SwiftUI

import SwiftUI

struct InspirationsView: View {
    @State private var images: [UnsplashPhoto] = []
    @State private var isLoading = false
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
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
                ScrollView {
                    if isLoading {
                        ProgressView("Lade Bilder...")
                    } else {
                        LazyVGrid(columns: columns, spacing: 8) {
                            ForEach(images) { image in
                                VStack(alignment: .leading, spacing: 4) {
                                    AsyncImage(url: URL(string: image.urls.small)) { phase in
                                        switch phase {
                                        case .empty:
                                            ProgressView()
                                                .frame(maxWidth: .infinity, minHeight: 150)
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .scaledToFit()
                                                .frame(maxWidth: .infinity, maxHeight: 150)
                                                .background(Color.gray.opacity(0.2))
                                                .cornerRadius(12)
                                        case .failure:
                                            Color.gray.frame(height: 150)
                                        @unknown default:
                                            EmptyView()
                                        }
                                    }
                                    
                                    // Attribution (Pflicht für Unsplash)
                                    Text("Photo by \(image.user.name)")
                                        .font(.caption2)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                        .padding()
                    }
                }
                .task {
                    await loadPhotos()
                }
                .navigationTitle("Inspirations")
            }
        }
    }
    
    private func fetchMotivationPhotos() async throws -> [UnsplashPhoto] {
        let urlString = "https://api.unsplash.com/search/photos?query=motivation&client_id=\(ApiKey.unsplash.rawValue)"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(UnsplashResponse.self, from: data)
        return decoded.results
    }
    
    private func loadPhotos() async {
        guard !isLoading else { return }
        isLoading = true
        defer { isLoading = false }
        
        do {
            images = try await fetchMotivationPhotos()
        } catch {
            print("Fehler beim Laden: \(error)")
        }
    }
}

//#Preview {
//    InspirationsView()
//}
