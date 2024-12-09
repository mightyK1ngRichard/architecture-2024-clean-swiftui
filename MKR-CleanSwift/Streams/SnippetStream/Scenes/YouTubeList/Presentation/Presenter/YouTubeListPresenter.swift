//
//  YouTubeListPresenter.swift
//  MKR-CleanSwift
//
//  Created by Dmitriy Permyakov on 07.12.2024.
//

import Foundation

final class YouTubeListPresenter: YouTubeListPresentationLogic {
    weak var viewModel: YouTubeListDisplayLogic?

    func presentSnippets(response: YouTubeListModel.Response.GetSnippetsResponse) {
        switch response {
        case let .data(data):
            presentSnippetsSuccess(data: data)
        case let .error(error):
            presentSnippetsFailure(error: error)
        }
    }

    func updateImagesStates(response: YouTubeListModel.Response.GetSnippetImagesResponse) {
        switch response {
        case let .data(data):
            imagesFetchingSuccess(data: data)
        case let .error(error):
            imagesFetchingFailed(with: error)
        }
    }
}

// MARK: - PresentSnippet Helper

private extension YouTubeListPresenter {
    func presentSnippetsSuccess(data: YouTubeSearchResponseEntity) {
        // Получаем сниппеты
        let snippetsEntities = data.items.compactMap { $0.snippet }
        let snippets = snippetsEntities.map { entity in
            YouTubeListModel.Snippet(
                id: entity.id,
                title: entity.title ?? "Заголовок не задан",
                imageState: .loading
            )
        }
        viewModel?.presentSnippets(snippets: snippets)
        // Обновляем токен для пагинации
        let pageToken = data.nextPageToken
        viewModel?.updatePageToken(pageToken)
    }

    func presentSnippetsFailure(error: Error) {
        let errorMessage: String
        if let error = error as? YouTubeListWebRepositoryImpl.NetworkError {
            errorMessage = error.description
        } else {
            errorMessage = error.localizedDescription
        }
        viewModel?.presentError(errorMessage: errorMessage)
    }
}

// MARK: - UpdateImagesStates Helper

private extension YouTubeListPresenter {
    func imagesFetchingSuccess(data: [(YouTubeSearchResponseEntity.YouTubeItemEntity.SnippetEntity, Result<Data, any Error>)]) {
        let snippets = data.map { snippet, imageResult in
            let imageState: ImageState
            switch imageResult {
            case let .success(imageData):
                imageState = .loaded(.data(imageData))
            case let .failure(error):
                if let error = error as? ImageLoader.ImageLoaderError {
                    Logger.log(kind: .error, message: error.description)
                } else {
                    Logger.log(kind: .error, message: error.localizedDescription)
                }
                imageState = .error(urlString: snippet.thumbnails?.high?.url)
            }
            return YouTubeListModel.Snippet(
                id: snippet.id,
                title: snippet.title ?? "Заголовок не задан",
                imageState: imageState
            )
        }
        viewModel?.updateImagesStates(for: snippets)
    }

    func imagesFetchingFailed(with error: Error) {
        let errorMessage: String
        if let error = error as? ImageLoader.ImageLoaderError {
            errorMessage = error.description
        } else {
            errorMessage = error.localizedDescription
        }
        viewModel?.imagesFetchingFailed(errorMessage: errorMessage)
    }
}
