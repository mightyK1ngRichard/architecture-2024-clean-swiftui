//
//  StubYouTubeListViewModel.swift
//  MKR-CleanSwiftTests
//
//  Created by Dmitriy Permyakov on 09.12.2024.
//

import Foundation
@testable import MKR_CleanSwift

final class StubYouTubeListViewModel: YouTubeListDisplayLogic {
    var snippets: [YouTubeListModel.Snippet] = []
    var screenState: ScreenState = .initial
    var pageToken: String?

    func fetch() {}
    func presentSnippets(snippets: [YouTubeListModel.Snippet]) {
        self.snippets = snippets
    }
    func updatePageToken(_ pageToken: String?) {
        self.pageToken = pageToken
    }
    func updateImagesStates(for snippets: [YouTubeListModel.Snippet]) {}
    func presentError(errorMessage: String) {}
    func imagesFetchingFailed(errorMessage: String) {}
    func makeConfiguration(from snippet: YouTubeListModel.Snippet) -> YouTubeSnippetCell.Configuration {
        YouTubeSnippetCell.Configuration(title: snippet.title, imageState: snippet.imageState)
    }
    func deleteSnippet(at indexSet: IndexSet) {}
}
