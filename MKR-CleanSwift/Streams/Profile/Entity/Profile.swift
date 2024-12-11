//
//  Profile.swift
//  MKR-CleanSwift
//
//  Created by Dmitriy Permyakov on 11.12.2024.
//

import Foundation

struct Profile {
    let name: String
    let status: String
    let imageData: Data?
}

// MARK: - Mock Data

#if DEBUG
import UIKit

extension Profile {
    static let mockData = Profile(
        name: "Test user name",
        status: "Test user status",
        imageData: UIImage.anime1.pngData()
    )
}
#endif
