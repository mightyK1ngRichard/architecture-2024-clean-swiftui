//
//  ScreenState.swift
//  MKR-CleanSwift
//
//  Created by Dmitriy Permyakov on 07.12.2024.
//

import Foundation

enum ScreenState: Hashable, Equatable {
    case initial
    case loading
    case loaded
    case error(_ errorMessage: String)
}

extension ScreenState {
    static func == (lhs: ScreenState, rhs: ScreenState) -> Bool {
        switch (lhs, rhs) {
        case (.initial, .initial):
            return true
        case (.loading, .loading):
            return true
        case (.loaded, .loaded):
            return true
        case let (.error(lhs), .error(rhs)):
            return lhs == rhs
        default: return false
        }
    }
}
