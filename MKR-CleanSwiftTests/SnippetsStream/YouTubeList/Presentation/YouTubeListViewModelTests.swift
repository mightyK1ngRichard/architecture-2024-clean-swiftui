//
//  YouTubeListViewModelTests.swift
//  MKR-CleanSwiftTests
//
//  Created by Dmitriy Permyakov on 09.12.2024.
//

import Testing
@testable import MKR_CleanSwift

struct YouTubeListViewModelTests {
    let viewModel = YouTubeListViewModel()

    @Test
    func makeConfiguration() async throws {
        let snippetTitle = "test title"

        // Корректное изображение
        let uiImageState = ImageState.loaded(.uiImage(.test))
        var snippet = YouTubeListModel.Snippet(
            id: "-1",
            title: snippetTitle,
            imageState: uiImageState
        )
        var configuration = viewModel.makeConfiguration(from: snippet)
        var correctConfiguarion = YouTubeSnippetCell.Configuration(title: snippetTitle, imageState: uiImageState)
        #expect(configuration == correctConfiguarion)

        // Лоудинг изображений
        snippet = YouTubeListModel.Snippet(
            id: "-2",
            title: snippetTitle,
            imageState: .loading
        )
        configuration = viewModel.makeConfiguration(from: snippet)
        correctConfiguarion = YouTubeSnippetCell.Configuration(title: snippetTitle, imageState: .loading)
        #expect(configuration == correctConfiguarion)

        // Ошибка изображения
        let errorImageState = ImageState.error(urlString: "http://test.com")
        snippet = YouTubeListModel.Snippet(
            id: "-3",
            title: snippetTitle,
            imageState: errorImageState
        )
        configuration = viewModel.makeConfiguration(from: snippet)
        correctConfiguarion = YouTubeSnippetCell.Configuration(title: snippetTitle, imageState: errorImageState)
        #expect(configuration == correctConfiguarion)
    }
}
