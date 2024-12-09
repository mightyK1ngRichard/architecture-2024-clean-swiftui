//
//  ImageKind.swift
//  MKR-CleanSwift
//
//  Created by Dmitriy Permyakov on 07.12.2024.
//

import Foundation
import UIKit

enum ImageKind: Hashable, Equatable {
    case data(Data)
    case uiImage(UIImage)
    case url(URL)
}

// MARK: - Equatable

extension ImageKind {
    static func == (lhs: ImageKind, rhs: ImageKind) -> Bool {
        switch (lhs, rhs) {
        case let (.data(lhsData), .data(rhsData)):
            return lhsData == rhsData
        case let (.uiImage(lhsImage), .uiImage(rhsImage)):
            return lhsImage == rhsImage
        case let (.url(lhsUrl), .url(rhsUrl)):
            return lhsUrl == rhsUrl
        default:
            return false
        }
    }
}
