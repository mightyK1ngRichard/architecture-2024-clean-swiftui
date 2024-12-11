//
//  ImageState.swift
//  MKR-CleanSwift
//
//  Created by Dmitriy Permyakov on 07.12.2024.
//

import Foundation

enum ImageState: Hashable, Equatable {
    case loading
    case loaded(ImageKind)
    case error(urlString: String? = nil)
}

// MARK: - Equatable

extension ImageState {
    static func == (lhs: ImageState, rhs: ImageState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            return true
        case let (.loaded(lhs), .loaded(rhs)):
            return lhs == rhs
        case let (.error(lhsURL), .error(rhsURL)):
            return lhsURL == rhsURL
        default:
            return false
        }
    }
}
