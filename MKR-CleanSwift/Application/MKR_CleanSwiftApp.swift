//
//  MKR_CleanSwiftApp.swift
//  MKR-CleanSwift
//
//  Created by Dmitriy Permyakov on 07.12.2024.
//

import SwiftUI

@main
struct MKR_CleanSwiftApp: App {
    var body: some Scene {
        WindowGroup {
            YouTubeList(viewModel: YouTubeListAssembly.shared.build())
        }
    }
}
