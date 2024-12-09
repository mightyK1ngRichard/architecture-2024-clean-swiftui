//
//  YouTubeListPresenterTests.swift
//  MKR-CleanSwiftTests
//
//  Created by Dmitriy Permyakov on 09.12.2024.
//

import Testing
import XCTest
@testable import MKR_CleanSwift

struct YouTubeListPresenterTests {
    let presenter: YouTubeListPresenter
    let viewModel = StubYouTubeListViewModel()

    init() {
        presenter = YouTubeListPresenter()
        presenter.viewModel = viewModel
    }

    @Test
    func presentSnippets() throws {
        let items: [YouTubeSearchResponseEntity.YouTubeItemEntity] = (0..<10).map {
            StubYouTubeListDataSource.youTubeItemEntity($0, query: "christmas")
        }
        let request = YouTubeListModel.Response.GetSnippetsResponse.data(
            YouTubeSearchResponseEntity(
                nextPageToken: "nextPageToken",
                prevPageToken: "prevPageToken",
                regionCode: "12345",
                items: items
            )
        )
        presenter.presentSnippets(response: request)
        let correctResult: [YouTubeListModel.Snippet] = items.compactMap { item in
            guard let snippet = item.snippet else { return nil }
            return YouTubeListModel.Snippet(
                id: snippet.id,
                title: snippet.title ?? "Заголовок не задан",
                imageState: .loading
            )
        }
        #expect(viewModel.snippets == correctResult)
    }
}
