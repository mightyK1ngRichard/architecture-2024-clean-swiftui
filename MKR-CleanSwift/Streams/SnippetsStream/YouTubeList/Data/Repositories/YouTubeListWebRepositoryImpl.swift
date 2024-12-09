//
//  YouTubeListWebRepositoryImpl.swift
//  MKR-CleanSwift
//
//  Created by Dmitriy Permyakov on 07.12.2024.
//

import Foundation

final class YouTubeListWebRepositoryImpl: YouTubeListWebRepository {
    let urlSession: URLSession

    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }

    func getSnippets(request: Request) async throws -> YouTubeSearchResponseEntity {
        guard let url = YouTubeNetworkRouter.search.buildURL(
            apiKey: request.apiKey,
            query: request.query,
            maxResults: request.maxResults,
            pageToken: request.pageToken,
            order: request.order
        ) else {
            #if DEBUG
            assertionFailure("Невалидный URL запроса")
            #endif
            throw NetworkError.invalidURL
        }

        let request = URLRequest(url: url)
        let (data, response) = try await urlSession.data(for: request)
        guard let response = response as? HTTPURLResponse else {
            throw NetworkError.responseMapError
        }
        guard 200..<300 ~= response.statusCode else {
            throw NetworkError.invalidResponse(response.statusCode)
        }
        do {
            return try JSONDecoder().decode(YouTubeSearchResponseEntity.self, from: data)
        } catch {
            throw NetworkError.decodeError(error)
        }
    }
}

// MARK: - Models

extension YouTubeListWebRepositoryImpl {

    struct Request {
        let apiKey: String
        let query: String
        let maxResults: String
        let pageToken: String?
        let order: String
    }

    enum NetworkError: Error, CustomStringConvertible {
        case invalidURL
        case responseMapError
        case invalidResponse(Int)
        case decodeError(Error)

        var description: String {
            switch self {
            case .invalidURL:
                return "Невалидный URL запроса"
            case .responseMapError:
                return "Не получилось привести response к HTTPURLResponse типу"
            case let .invalidResponse(code):
                return "Невалидный status code: \(code)"
            case let .decodeError(error):
                return "Не получилось декодировать JSON: \(error)"
            }
        }
    }
}
