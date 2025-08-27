//
//  Author.swift
//  Quotely
//
//  Created by Jeff Braun on 27.08.25.
//

import Foundation

struct Author: Codable, Identifiable {
    var id: String
    var name: String
    var slug: String
}
