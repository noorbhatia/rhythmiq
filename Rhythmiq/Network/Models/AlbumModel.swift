//
//  AlbumModel.swift
//  Rhythmiq
//
//  Created by noor on 16/05/23.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let newRelease = try? JSONDecoder().decode(NewRelease.self, from: jsonData)

import Foundation

// MARK: - NewRelease
struct NewRelease: Codable {
    let albums: Albums
}

// MARK: - Albums
struct Albums: Codable {
    let href: String
    let items: [AlbumItem]
    let limit: Int
    let next: String
    let offset: Int
    let previous: Int?
    let total: Int
}

// MARK: - Item
struct AlbumItem: Codable {
    let albumType: AlbumTypeEnum?
    let artists: [Artist]?
    let availableMarkets: [String]?
    let externalUrls: ExternalUrls?
    let href: String?
    let id: String
    let images: [AlbumImage]
    let name, releaseDate: String?
    let releaseDatePrecision: ReleaseDatePrecision?
    let totalTracks: Int?
    let type: AlbumTypeEnum?
    let uri: String?

    enum CodingKeys: String, CodingKey {
        case albumType = "album_type"
        case artists
        case availableMarkets = "available_markets"
        case externalUrls = "external_urls"
        case href, id, images, name
        case releaseDate = "release_date"
        case releaseDatePrecision = "release_date_precision"
        case totalTracks = "total_tracks"
        case type, uri
    }
}

enum AlbumTypeEnum: String, Codable {
    case album = "album"
    case compilation = "compilation"
    case single = "single"
}

// MARK: - Artist
struct Artist: Codable {
    let externalUrls: ExternalUrls
    let href: String
    let id, name: String
    let type: ArtistType
    let uri: String

    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case href, id, name, type, uri
    }
}

// MARK: - ExternalUrls
struct ExternalUrls: Codable {
    let spotify: String
}

enum ArtistType: String, Codable {
    case artist = "artist"
}

// MARK: - Image
struct AlbumImage: Codable {
    let height: Int?
    let url: String
    let width: Int?
}

enum ReleaseDatePrecision: String, Codable {
    case day = "day"
}

