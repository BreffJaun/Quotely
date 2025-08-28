//
//  QuoteError.swift
//  Quotely
//
//  Created by Jeff Braun on 28.08.25.
//

import Foundation

struct QuoteError: LocalizedError {
    let reason: String
    
    var errorDescription: String? {
        "Quote could not be loaded."
    }
    
    var recoverySuggestion: String? {
        "Reason: \(reason)\nPlease check your internet connection or try again."
    }
}
