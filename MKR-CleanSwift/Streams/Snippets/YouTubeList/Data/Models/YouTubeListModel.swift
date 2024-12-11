//
//  YouTubeListModel.swift
//  MKR-CleanSwift
//
//  Created by Dmitriy Permyakov on 07.12.2024.
//

import Foundation

// MARK: - YouTubeListModel

enum YouTubeListModel {
    enum Request {}
    enum Response {}
}

// MARK: - Request

extension YouTubeListModel.Request {
    struct GetSnippetsRequest {
        let apiKey: String
        let query: String
        let maxResults: String
        let pageToken: String?
        let order: String
    }

    struct GetSnippetImagesRequest {
        let snippets: [YouTubeSearchResponseEntity.YouTubeItemEntity.SnippetEntity]
    }

    struct DeleteSnippetRequest {
        let snippet: YouTubeListModel.Snippet
    }
}

// MARK: - Response

extension YouTubeListModel.Response {
    enum GetSnippetsResponse {
        case data(YouTubeSearchResponseEntity)
        case error(Error)
    }

    enum GetSnippetImagesResponse {
        case data([(YouTubeSearchResponseEntity.YouTubeItemEntity.SnippetEntity, Result<Data, Error>)])
        case error(Error)
    }
}

// MARK: - Snippet

extension YouTubeListModel {
    struct Snippet: Identifiable, Hashable, Equatable {
        let id: String
        let title: String
        var imageState: ImageState
    }
}

extension YouTubeListModel.Snippet {
    static func == (lhs: YouTubeListModel.Snippet, rhs: YouTubeListModel.Snippet) -> Bool {
        lhs.id == rhs.id
        && lhs.title == rhs.title
        && lhs.imageState == rhs.imageState
    }
}
