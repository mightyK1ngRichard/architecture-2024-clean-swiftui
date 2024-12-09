//
//  YouTubeListContract.swift
//  MKR-CleanSwift
//
//  Created by Dmitriy Permyakov on 07.12.2024.
//

import Foundation

// MARK: - YouTubeListDisplayLogic

protocol YouTubeListDisplayLogic: AnyObject {
    // Values
    var snippets: [YouTubeListModel.Snippet] { get }
    var screenState: ScreenState { get }
    // Network
    func fetch()
    // Display data
    func presentSnippets(snippets: [YouTubeListModel.Snippet])
    func updateImagesStates(for snippets: [YouTubeListModel.Snippet])
    func presentError(errorMessage: String)
    func updatePageToken(_ pageToken: String?)
    func imagesFetchingFailed(errorMessage: String)
    func makeConfiguration(from snippet: YouTubeListModel.Snippet) -> YouTubeSnippetCell.Configuration
    // Actions
    func deleteSnippet(at indexSet: IndexSet)
}

// MARK: - YouTubeListWebRepository

protocol YouTubeListWebRepository {
    func getSnippets(request: YouTubeListWebRepositoryImpl.Request) async throws -> YouTubeSearchResponseEntity
}

// MARK: - YouTubeListBusinessLogic

protocol YouTubeListBusinessLogic: AnyObject {
    func fetchSnippets(request: YouTubeListModel.Request.GetSnippetsRequest)
    func getSnippetsImages(request: YouTubeListModel.Request.GetSnippetImagesRequest)
    func deleteSnippet(request: YouTubeListModel.Request.DeleteSnippetRequest)
}

// MARK: - YouTubeListPresentationLogic

protocol YouTubeListPresentationLogic: AnyObject {
    func presentSnippets(response: YouTubeListModel.Response.GetSnippetsResponse)
    func updateImagesStates(response: YouTubeListModel.Response.GetSnippetImagesResponse)
}
