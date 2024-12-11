//
//  CatImageService.swift
//  MKR-CleanSwift
//
//  Created by Dmitriy Permyakov on 11.12.2024.
//

import Foundation

protocol CatImageServiceProtocol {
    func randomCatImage() async throws -> Data
}

final class CatImageServiceImpl: CatImageServiceProtocol {
    private let urlString = "https://cataas.com/cat"
    let urlSession: URLSession

    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
}

// MARK: - CatImageServiceProtocol

extension CatImageServiceImpl {
    func randomCatImage() async throws -> Data {
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }

        let request = URLRequest(url: url)
        let (data, _) = try await urlSession.data(for: request)
        return data
    }
}

// MARK: - NetworkError

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case customError(Error)
}
