//
//  StubYouTubeListDataSource.swift
//  MKR-CleanSwiftTests
//
//  Created by Dmitriy Permyakov on 09.12.2024.
//

import Foundation
@testable import MKR_CleanSwift

enum StubYouTubeListDataSource {
    static let apiKey = "test_api_key"

    static func youTubeItemEntity(_ number: Int, query: String) -> YouTubeSearchResponseEntity.YouTubeItemEntity {
        YouTubeSearchResponseEntity.YouTubeItemEntity(
            etag: "etag-\(number)",
            id: .init(videoId: "vidioId-\(number)"),
            snippet: .init(
                publishedAt: "14/03/2003",
                channelId: "channelId",
                title: "test title \(query) #\(number)",
                description: "test description \(query) #\(number)",
                thumbnails: .init(
                    high: .init(
                        url: "https://sun9-52.userapi.com/impg/oSXWW7oZ327CMUCfXZeTniGuZbv2Q1hkSpWMfg/JTxbp8VDDZg.jpg?size=1620x2160&quality=95&sign=dc7aacb5644ae511037869fbfbddc3d9&type=album",
                        width: 300,
                        height: 150
                    )
                ),
                channelTitle: "channelTitle \(number)"
            )
        )
    }
}
