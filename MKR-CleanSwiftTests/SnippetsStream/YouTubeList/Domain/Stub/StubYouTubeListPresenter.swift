//
//  StubYouTubeListPresenter.swift
//  MKR-CleanSwiftTests
//
//  Created by Dmitriy Permyakov on 09.12.2024.
//

import Foundation
@testable import MKR_CleanSwift

final class StubYouTubeListPresenter: YouTubeListPresentationLogic {
    var snippetsResponse: YouTubeListModel.Response.GetSnippetsResponse?
    var updateImagesStatesResponse: YouTubeListModel.Response.GetSnippetImagesResponse?

    func presentSnippets(response: YouTubeListModel.Response.GetSnippetsResponse) {
        snippetsResponse = response
    }

    func updateImagesStates(response: YouTubeListModel.Response.GetSnippetImagesResponse) {
        updateImagesStatesResponse = response
    }
}

extension StubWebRepositoryImpl {
    enum NetworkError: Error {
        case invalidApiKey
        case IntConversionError
    }
}
