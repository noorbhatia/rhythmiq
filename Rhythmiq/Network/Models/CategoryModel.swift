//
//  CategoryModel.swift
//  Rhythmiq
//
//  Created by noor on 14/05/23.
//

import Foundation
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let category = try? JSONDecoder().decode(Category.self, from: jsonData)



// MARK: - Category
struct Category: Codable {
    let categories: Categories
}
// MARK: - Categories
struct Categories: Codable {
    let href: String
    let items: [Item]
    let limit: Int
    let next: String
    let offset: Int
    let previous: Int?
    let total: Int
}

// MARK: - Item
struct Item: Codable {
    let href: String?
    let icons: [Icon]?
    let id, name: String
}

// MARK: - Icon
struct Icon: Codable {
    let height: Int?
    let url: String
    let width: Int?
}

