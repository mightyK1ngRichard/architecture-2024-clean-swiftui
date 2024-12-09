//
//  YouTubeSearchResponseEntity.swift
//  MKR-CleanSwift
//
//  Created by Dmitriy Permyakov on 07.12.2024.
//

import Foundation

struct YouTubeSearchResponseEntity: Decodable, Hashable, Equatable {
    let nextPageToken: String?
    let prevPageToken: String?
    let regionCode: String
    let items: [YouTubeItemEntity]
}

// MARK: - YouTubeItemEntity

extension YouTubeSearchResponseEntity {
    struct YouTubeItemEntity: Decodable, Hashable, Equatable {
        let etag: String
        let id: ItemIDEntity?
        let snippet: SnippetEntity?
    }
}

// MARK: - SearchItemID & SnippetEntity

extension YouTubeSearchResponseEntity.YouTubeItemEntity {
    struct ItemIDEntity: Decodable, Hashable, Equatable {
        let videoId: String?
    }

    struct SnippetEntity: Decodable, Hashable, Equatable {
        let publishedAt: String?
        let channelId: String?
        let title: String?
        let description: String?
        let thumbnails: SearchItemThumbnails?
        let channelTitle: String?

        var id: String { [channelId, title, description].compactMap { $0 }.joined() }
    }
}

extension YouTubeSearchResponseEntity.YouTubeItemEntity.SnippetEntity {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.publishedAt == rhs.publishedAt
        && lhs.channelId == rhs.channelId
        && lhs.title == rhs.title
        && lhs.description == rhs.description
        && lhs.thumbnails == rhs.thumbnails
        && lhs.channelTitle == rhs.channelTitle
    }
}

// MARK: - SearchItemThumbnails

extension YouTubeSearchResponseEntity.YouTubeItemEntity.SnippetEntity {
    struct SearchItemThumbnails: Decodable, Hashable, Equatable {
        let high: ThumbnailsData?
    }
}

extension YouTubeSearchResponseEntity.YouTubeItemEntity.SnippetEntity.SearchItemThumbnails {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.high == rhs.high
    }
}

// MARK: - ThumbnailsData

extension YouTubeSearchResponseEntity.YouTubeItemEntity.SnippetEntity.SearchItemThumbnails {
    struct ThumbnailsData: Decodable, Hashable, Equatable {
        let url: String?
        let width: Int?
        let height: Int?
    }
}

extension YouTubeSearchResponseEntity.YouTubeItemEntity.SnippetEntity.SearchItemThumbnails.ThumbnailsData {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.url == rhs.url
        && lhs.width == rhs.width
        && lhs.height == rhs.height
    }
}
