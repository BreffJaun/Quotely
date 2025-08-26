//
//  HTTPError.swift
//  03_W06_Notes
//
//  Created by Jeff Braun on 26.08.25.
//

import Foundation

enum HTTPError: String, Error  {
    case invalidURL = "Invalid URL"
    case fetchFailed = "Loading data failed"
    case invalidResponse = "Invalid Response"
    
}
