//
//  YouTubeListViewModel.swift
//  MKR-CleanSwift
//
//  Created by Dmitriy Permyakov on 07.12.2024.
//

import Foundation
import Observation

@Observable
final class YouTubeListViewModel: YouTubeListDisplayLogic {
    @ObservationIgnored
    var interactor: YouTubeListBusinessLogic?

    private(set) var snippets: [YouTubeListModel.Snippet]
    private(set) var screenState: ScreenState
    @ObservationIgnored
    private(set) var pageToken: String?

    init(
        snippets: [YouTubeListModel.Snippet] = [],
        screenState: ScreenState = .initial,
        pageToken: String? = nil
    ) {
        self.snippets = snippets
        self.screenState = screenState
        self.pageToken = pageToken
    }
}

// MARK: - Network

extension YouTubeListViewModel {
    func fetch() {
        screenState = .loaded
        interactor?.fetchSnippets(
            request: .init(
                apiKey: "AIzaSyAK4_jq6NNxomoCIOzH3C2Ft2z2PzmvZYU",
                query: "christmas",
                maxResults: "100",
                pageToken: pageToken,
                order: "relevance"
            )
        )
    }
}

// MARK: - Display data

extension YouTubeListViewModel {
    func makeConfiguration(from snippet: YouTubeListModel.Snippet) -> YouTubeSnippetCell.Configuration {
        YouTubeSnippetCell.Configuration(title: snippet.title, imageState: snippet.imageState)
    }

    func presentSnippets(snippets: [YouTubeListModel.Snippet]) {
        self.snippets = snippets
        screenState = .loaded
    }

    func presentError(errorMessage: String) {
        screenState = .error(errorMessage)
    }

    func updatePageToken(_ pageToken: String?) {
        self.pageToken = pageToken
    }

    func updateImagesStates(for snippets: [YouTubeListModel.Snippet]) {
        for snippet in snippets {
            guard
                let index = snippets.firstIndex(where: { $0.id == snippet.id && $0.title == snippet.title })
            else {
                Logger.log(kind: .error, message: "Сниппет id=\(snippet.id) не найден на экране. Изображение не обновлено")
                continue
            }
            self.snippets[index].imageState = snippet.imageState
        }
    }

    func deleteSnippet(at indexSet: IndexSet) {
        for index in indexSet {
            let snippet = snippets.remove(at: index)
            interactor?.deleteSnippet(request: .init(snippet: snippet))
        }
    }

    func imagesFetchingFailed(errorMessage: String) {
        Logger.log(kind: .error, message: errorMessage)
    }
}
