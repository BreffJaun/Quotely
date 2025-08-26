//
//  CategoryItemModel.swift
//  Quotely
//
//  Created by Jeff Braun on 26.08.25.
//

import Foundation

struct CategoryItemModel: Codable, Identifiable, Hashable {
    var id: String { name }
    let name: String
}
