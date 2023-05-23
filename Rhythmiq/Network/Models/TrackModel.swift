//
//  TrackModel.swift
//  Rhythmiq
//
//  Created by noor on 22/05/23.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let trackModel = try? JSONDecoder().decode(TrackModel.self, from: jsonData)

import Foundation

// MARK: - TrackModel
struct TrackModel: Codable {
    let href: String
    let items: [TrackItem]
    let limit: Int
    let next: String?
    let offset: Int
    let previous: String?
    let total: Int
}

// MARK: - Item
struct TrackItem: Codable {
    let isLocal: Bool
    let track: Track

    enum CodingKeys: String, CodingKey {
        case isLocal = "is_local"
        case track
    }
}





// MARK: - Track
struct Track: Codable {
    let album: AlbumItem
    let availableMarkets: [String]
    let discNumber, durationMS: Int
    let episode, explicit: Bool
    let externalIDS: ExternalIDS
    let externalUrls: ExternalUrls
    let href: String
    let id: String
    let isLocal: Bool
    let name: String
    let popularity: Int
    let previewURL: String?
    let track: Bool
    let trackNumber: Int
    let type: String?
    let uri: String

    enum CodingKeys: String, CodingKey {
        case album
        case availableMarkets = "available_markets"
        case discNumber = "disc_number"
        case durationMS = "duration_ms"
        case episode, explicit
        case externalIDS = "external_ids"
        case externalUrls = "external_urls"
        case href, id
        case isLocal = "is_local"
        case name, popularity
        case previewURL = "preview_url"
        case track
        case trackNumber = "track_number"
        case type, uri
    }
}




// MARK: - ExternalIDS
struct ExternalIDS: Codable {
    let isrc: String
}



