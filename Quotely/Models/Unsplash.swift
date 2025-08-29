//
//  Unsplash.swift
//  Quotely
//
//  Created by Jeff Braun on 27.08.25.
//

import Foundation

struct UnsplashResponse: Codable {
    let results: [UnsplashPhoto]
}

struct UnsplashPhoto: Codable, Identifiable {
    let id: String
    let urls: Urls
    let user: User
}

struct Urls: Codable {
    let small: String
}

struct User: Codable {
    let name: String
    let links: Links
}

struct Links: Codable {
    let html: String
}
