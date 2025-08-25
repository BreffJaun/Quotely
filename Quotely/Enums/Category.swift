//
//  Category.swift
//  Quotely
//
//  Created by Jeff Braun on 25.08.25.
//

import Foundation

enum Category: String, Codable, CaseIterable {
    case motivation = "Motivation"
    case life = "Life"
    case love = "Love"
    case wisdom = "Wisdom"
    case success = "Success"
    case happiness = "Happiness"
    case courage = "Courage"
    case friendship = "Friendship"
    case education = "Education"
    case future = "Future"
}

let categories = Category.allCases
let gridCategories: [[Category]] = stride(from: 0, to: categories.count, by: 2).map { i in
    let end = min(i + 2, categories.count)
    return Array(categories[i..<end])
}
