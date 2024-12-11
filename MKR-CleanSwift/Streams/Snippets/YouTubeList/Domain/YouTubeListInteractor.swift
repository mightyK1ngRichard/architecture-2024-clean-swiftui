//
//  YouTubeListInteractor.swift
//  MKR-CleanSwift
//
//  Created by Dmitriy Permyakov on 07.12.2024.
//

import Foundation

final class YouTubeListInteractor: YouTubeListBusinessLogic {
    var presenter: YouTubeListPresentationLogic?
    private let webRepository: YouTubeListWebRepository
    private let imageLoaderService: ImageLoader
    private var snippetsTask: Task<Void, Never>?

    init(
        webRepository: YouTubeListWebRepository,
        imageLoaderService: ImageLoader
    ) {
        self.webRepository = webRepository
        self.imageLoaderService = imageLoaderService
    }
}

extension YouTubeListInteractor {
    func fetchSnippets(request: YouTubeListModel.Request.GetSnippetsRequest) {
        snippetsTask = Task {
            do {
                let response = try await webRepository.getSnippets(
                    request: .init(
                        apiKey: request.apiKey,
                        query: request.query,
                        maxResults: request.maxResults,
                        pageToken: request.pageToken,
                        order: request.order
                    )
                )
                // Запускаем процесс получения изображений
                getSnippetsImages(request: .init(snippets: response.items.compactMap(\.snippet)))
                await MainActor.run {
                    presenter?.presentSnippets(response: .data(response))
                }
            } catch {
                await MainActor.run {
                    presenter?.presentSnippets(response: .error(error))
                }
            }
        }
    }

    func getSnippetsImages(request: YouTubeListModel.Request.GetSnippetImagesRequest) {
        let imagesURlsWithSnippets = request.snippets.map { snippet in
            var image: URL? = nil
            if let urlString = snippet.thumbnails?.high?.url {
                image = URL(string: urlString)
            }
            return (snippet, image)
        }
        Task {
            do {
                let response = try await imageLoaderService.getImages(urlsWithKeys: imagesURlsWithSnippets)
                await MainActor.run {
                    presenter?.updateImagesStates(response: .data(response))
                }
            } catch {
                await MainActor.run {
                    presenter?.updateImagesStates(response: .error(error))
                }
            }
        }
    }

    func deleteSnippet(request: YouTubeListModel.Request.DeleteSnippetRequest) {
        print("[DEBUG]: Был удалён snippet: \(request.snippet)")
    }
}
