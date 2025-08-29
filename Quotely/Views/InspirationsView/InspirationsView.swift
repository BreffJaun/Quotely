//
//  InspirationsView.swift
//  Quotely
//
//  Created by Jeff Braun on 25.08.25.
//

import SwiftUI

struct InspirationsView: View {
    
    @State private var images: [UnsplashPhoto] = []
    @State private var isLoading = false
    @State private var inspirationError: QuoteError?
    
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
                                    AsyncImage(url: URL(string: image.urls.small)) {
                                        //                                    AsyncImage(url: URL(string: "https://example.com/doesnotexist.jpg")) {
                                        
                                        phase in
                                        switch phase {
                                        case .empty:
                                            
                                            ZStack {
                                                Color.gray.opacity(0.1)
                                                ProgressView()
                                            }
                                            .frame(maxWidth: .infinity, minHeight: 150)
                                            .cornerRadius(12)
                                            
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .scaledToFit()
                                                .frame(maxWidth: .infinity, maxHeight: 150)
                                                .background(Color.gray.opacity(0.2))
                                                .cornerRadius(12)
                                        case .failure(_): //eigentlich kommt error hier hin!!!
                                            VStack {
                                                Image(systemName: "exclamationmark.triangle.fill")
                                                    .foregroundColor(.orange)
                                                    .font(.system(size: 30))
                                                Text("Bild konnte nicht geladen werden")
                                                    .font(.caption)
                                                    .foregroundColor(.secondary)
                                            }
                                            .frame(maxWidth: .infinity, minHeight: 150)
                                            .background(Color.gray.opacity(0.2))
                                            .cornerRadius(12)
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
        
    private func loadPhotos() async {
        guard !isLoading else { return }
        isLoading = true
        defer { isLoading = false }
        
        do {
            images = try await NetworkService.sendData(
                to: URLs.unsplah(apiKey: ApiKey.unsplash.rawValue),
                responseType: UnsplashResponse.self
            ).results
            inspirationError = nil
        } catch let error as HTTPError {
            images = []
            inspirationError = QuoteError(reason: error.errorDescription ?? "Unknown HTTP error")
        } catch {
            images = []
            inspirationError = QuoteError(reason: error.localizedDescription)
        }
    }
}

//#Preview {
//    InspirationsView()
//}
