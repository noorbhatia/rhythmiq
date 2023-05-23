//
//  PlaylistModel.swift
//  Rhythmiq
//
//  Created by noor on 20/05/23.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let playlist = try? JSONDecoder().decode(Playlist.self, from: jsonData)

import Foundation

// MARK: - Playlist
struct Playlist: Codable {
    let playlists: Playlists
}

// MARK: - Playlists
struct Playlists: Codable {
    let href: String
    let items: [PlaylistItem]
    let limit: Int?
    let next: String?
    let offset: Int?
    let previous: String?
    let total: Int
}



struct PlaylistItem: Codable {
    let description: String
    let externalUrls: ExternalUrls
    let href: String
    let id: String
    let images: [AlbumImage]
    let name: String
    let owner: Owner
    let snapshotID: String
    let tracks: Tracks
    let type: ItemType
    let uri: String

    enum CodingKeys: String, CodingKey {
        case description
        case externalUrls = "external_urls"
        case href, id, images, name, owner
        case snapshotID = "snapshot_id"
        case tracks, type, uri
    }
}

// MARK: - Owner
struct Owner: Codable {
    let displayName: DisplayName
    let externalUrls: ExternalUrls
    let href: String
    let id: ID
    let type: OwnerType
    let uri: URI

    enum CodingKeys: String, CodingKey {
        case displayName = "display_name"
        case externalUrls = "external_urls"
        case href, id, type, uri
    }
}

enum DisplayName: String, Codable {
    case spotify = "Spotify"
}

enum ID: String, Codable {
    case spotify = "spotify"
}

enum OwnerType: String, Codable {
    case user = "user"
}

enum URI: String, Codable {
    case spotifyUserSpotify = "spotify:user:spotify"
}

// MARK: - Tracks
struct Tracks: Codable {
    let href: String
    let total: Int
}

enum ItemType: String, Codable {
    case playlist = "playlist"
}
