//
//  YouTubeListInteractorTests.swift
//  MKR-CleanSwiftTests
//
//  Created by Dmitriy Permyakov on 09.12.2024.
//

import Testing
import XCTest
@testable import MKR_CleanSwift

struct YouTubeListInteractorTests {
    var sut: YouTubeListInteractor

    init() {
        let webRepository = StubWebRepositoryImpl()
        let imageLoaderService = ImageLoader()
        let presenter = StubYouTubeListPresenter()
        sut = YouTubeListInteractor(webRepository: webRepository, imageLoaderService: imageLoaderService)
        sut.presenter = presenter
    }

    @Test
    func fetchSnippets() async throws {
        let countItems = 3
        let request = YouTubeListModel.Request.GetSnippetsRequest(
            apiKey: StubYouTubeListDataSource.apiKey,
            query: "cristmas",
            maxResults: String(countItems),
            pageToken: "startToken",
            order: ""
        )
        sut.fetchSnippets(request: request)
        try await Task.sleep(for: .seconds(0.1))
        let entity = YouTubeSearchResponseEntity(
            nextPageToken: "nextPageToken",
            prevPageToken: request.pageToken,
            regionCode: "12345",
            items: (0..<countItems).map {
                StubYouTubeListDataSource.youTubeItemEntity($0, query: "cristmas")
            }
        )
        let correctResponse = YouTubeListModel.Response.GetSnippetsResponse.data(entity)
        let presenter = try XCTUnwrap(sut.presenter as? StubYouTubeListPresenter)
        let presenterSnippetsResponse = try XCTUnwrap(presenter.snippetsResponse)
        #expect(presenterSnippetsResponse == correctResponse)
    }

    @Test
    func getSnippetsImages() async throws {
        let snippets = (0..<4).compactMap {
            StubYouTubeListDataSource.youTubeItemEntity($0, query: "testing").snippet
        }
        let request = YouTubeListModel.Request.GetSnippetImagesRequest(snippets: snippets)
        sut.getSnippetsImages(request: request)
        try await Task.sleep(for: .seconds(1.5))
        let presenter = try XCTUnwrap(sut.presenter as? StubYouTubeListPresenter)
        let presenterData: [(YouTubeSearchResponseEntity.YouTubeItemEntity.SnippetEntity, Result<Data, Error>)]
        switch presenter.updateImagesStatesResponse {
        case let .data(data):
            presenterData = data
        default:
            Issue.record("Фотографии не должны возвращаться с ошибкой")
            return
        }
        #expect(presenterData.count == 4)
    }
}

// MARK: - GetSnippetsResponse

private extension YouTubeListModel.Response.GetSnippetsResponse {
    static func == (lhs: YouTubeListModel.Response.GetSnippetsResponse, rhs: YouTubeListModel.Response.GetSnippetsResponse) -> Bool {
        switch (lhs, rhs) {
        case let (.data(lhs), .data(rhs)):
            return lhs == rhs
        default:
            return false
        }
    }
}
