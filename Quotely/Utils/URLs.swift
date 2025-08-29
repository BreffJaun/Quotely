//
//  URLs.swift
//  Quotely
//
//  Created by Jeff Braun on 29.08.25.
//

import Foundation

struct URLs {
    static let base = "https://si-classroom-batch-027.github.io/"
    static let quotes = "https://si-classroom-batch-027.github.io/quotes/quotes.json"
    static let authors = "https://si-classroom-batch-027.github.io/quotes/authors.json"
    static let categories = "https://si-classroom-batch-027.github.io/quotes/categories.json"
    
    static func authorQuotes(slug: String) -> String {
        return "https://si-classroom-batch-027.github.io/quotes/quotes/\(slug).json"
    }
    
    static func specificCat(cat: String) -> String {
        return "https://si-classroom-batch-027.github.io/quotes/quotes/\(cat).json"
    }
    
    static func unsplah(apiKey: String) -> String {
        return "https://api.unsplash.com/search/photos?query=motivation&client_id=\(apiKey)"
    }
    
}


