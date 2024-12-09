//
//  YouTubeListViewModel+Mock.swift
//  MKR-CleanSwift
//
//  Created by Dmitriy Permyakov on 07.12.2024.
//

#if DEBUG

import Foundation
import Observation
import UIKit

@Observable
final class YouTubeListViewModelMock: YouTubeListDisplayLogic {
    var delay: TimeInterval
    var screenState: ScreenState
    var snippets: [YouTubeListModel.Snippet]

    init(
        delay: TimeInterval,
        screenState: ScreenState = .initial,
        snippets: [YouTubeListModel.Snippet] = []
    ) {
        self.delay = delay
        self.screenState = screenState
        self.snippets = snippets
    }

    func fetch() {
        guard screenState == .initial else { return }
        screenState = .loading
        Task {
            try? await Task.sleep(for: .seconds(delay))
            let tempSnipptets: [YouTubeListModel.Snippet] = (1...10).map {
                .init(
                    id: String($0),
                    title: "Просто описание какого-то видео #\($0). Давайте посмотрим что-то новогоднее!",
                    imageState: .loading
                )
            }

            await MainActor.run {
                snippets = tempSnipptets
                screenState = .loaded

                updateImagesStates(for: tempSnipptets.map { .init(id: $0.id, title: $0.title, imageState: .loading) })
            }
        }
    }

    func makeConfiguration(from snippet: YouTubeListModel.Snippet) -> YouTubeSnippetCell.Configuration {
        .init(title: snippet.title, imageState: snippet.imageState)
    }

    func presentSnippets(snippets: [YouTubeListModel.Snippet]) {}

    func presentError(errorMessage: String) {}

    func updatePageToken(_ pageToken: String?) {}

    func updateImagesStates(for snippets: [YouTubeListModel.Snippet]) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.snippets = snippets.map {
                YouTubeListModel.Snippet(id: $0.id, title: $0.title, imageState: .loaded(
                    .uiImage((Int($0.id) ?? 0) % 2 == 0 ? UIImage(resource: .anime1) : UIImage(resource: .anime2))
                ))
            }
        }

    }

    func deleteSnippet(at indexSet: IndexSet) {
        for index in indexSet {
            snippets.remove(at: index)
        }
    }

    func imagesFetchingFailed(errorMessage: String) {}
}

#endif
