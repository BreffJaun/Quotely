//
//  Unsplash.swift
//  Quotely
//
//  Created by Jeff Braun on 27.08.25.
//

import Foundation

struct UnsplashResponse: Decodable {
    let results: [UnsplashPhoto]
}

struct UnsplashPhoto: Decodable, Identifiable {
    let id: String
    let urls: Urls
    let user: User
    
    struct Urls: Decodable {
        let small: String
    }
    
    struct User: Decodable {
        let name: String
        let links: Links
        
        struct Links: Decodable {
            let html: String
        }
    }
}
