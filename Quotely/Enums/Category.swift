//
//  Category.swift
//  Quotely
//
//  Created by Jeff Braun on 25.08.25.
//

import Foundation

enum Category: String, Codable, CaseIterable {
    case motivation = "motivation"
    case life = "life"
    case love = "love"
    case wisdom = "wisdom"
    case success = "success"
    case happiness = "happiness"
    case courage = "courage"
    case friendship = "friendship"
    case education = "education"
    case future = "future"
}

let categories = Category.allCases
let gridCategories: [[Category]] = stride(from: 0, to: categories.count, by: 2).map { i in
    let end = min(i + 2, categories.count)
    return Array(categories[i..<end])
}
