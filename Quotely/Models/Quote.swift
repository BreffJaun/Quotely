//
//  Quote.swift
//  Quotely
//
//  Created by Jeff Braun on 25.08.25.
//

import Foundation
import SwiftData
import UIKit

struct Quote: Codable, Identifiable, Hashable {
    var id: String = UUID().uuidString
    var text: String
    var author: String
    var category: Category
    var language: Language
}




