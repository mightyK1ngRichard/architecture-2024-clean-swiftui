//
//  ImageLoader.swift
//  MKR-CleanSwift
//
//  Created by Dmitriy Permyakov on 07.12.2024.
//

import Foundation

final class ImageLoader {
    private let urlSession: URLSession

    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
}

extension ImageLoader {
    func getImage(from url: URL?) async throws -> Data {
        guard let url else { throw ImageLoaderError.urlIsNil }
        let request = URLRequest(url: url, timeoutInterval: 6)
        let (data, response) = try await urlSession.data(for: request)
        guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
            throw ImageLoaderError.badResponse
        }
        return data
    }

    func getImages<T: Hashable & Equatable>(
        urlsWithKeys: [(key: T, url: URL?)]
    ) async throws -> [(T, Result<Data, Error>)] {
        try await withThrowingTaskGroup(of: (T, Result<Data, Error>).self) { group in
            for (key, url) in urlsWithKeys {
                group.addTask {
                    if Task.isCancelled {
                        throw ImageLoaderError.taskDidCancel
                    }
                    do {
                        let imageData = try await self.getImage(from: url)
                        return (key, .success(imageData))
                    } catch {
                        Logger.log(kind: .error, message: "Ошибка получения изображения: \(error)")
                        return (key, .failure(error))
                    }
                }
            }
            var response: [(T, Result<Data, Error>)] = []
            for try await result in group {
                if Task.isCancelled {
                    throw ImageLoaderError.taskDidCancel
                }
                response.append(result)
            }
            return response
        }
    }
}

extension ImageLoader {
    enum ImageLoaderError: Error, CustomStringConvertible {
        case badResponse
        case urlIsNil
        case taskDidCancel

        var description: String {
            switch self {
            case .badResponse:
                return "Плохой статус код"
            case .urlIsNil:
                return "URL не указан"
            case .taskDidCancel:
                return "Задача была отменена"
            }
        }
    }
}
