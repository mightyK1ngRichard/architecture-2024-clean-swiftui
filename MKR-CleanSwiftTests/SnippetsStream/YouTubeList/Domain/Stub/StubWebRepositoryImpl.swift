//
//  StubWebRepositoryImpl.swift
//  MKR-CleanSwiftTests
//
//  Created by Dmitriy Permyakov on 09.12.2024.
//

import Foundation
@testable import MKR_CleanSwift

final class StubWebRepositoryImpl: YouTubeListWebRepository {
    func getSnippets(request: YouTubeListWebRepositoryImpl.Request) async throws -> YouTubeSearchResponseEntity {
        if request.apiKey == StubYouTubeListDataSource.apiKey {
            guard let count = Int(request.maxResults) else {
                throw NetworkError.IntConversionError
            }
            return YouTubeSearchResponseEntity(
                nextPageToken: "nextPageToken",
                prevPageToken: request.pageToken,
                regionCode: "12345",
                items: (0..<count).map {
                    StubYouTubeListDataSource.youTubeItemEntity($0, query: request.query)
                }
            )
        }
        throw NetworkError.invalidApiKey
    }
}
