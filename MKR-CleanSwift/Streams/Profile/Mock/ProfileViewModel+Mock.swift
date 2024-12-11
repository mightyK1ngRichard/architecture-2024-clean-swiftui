//
//  ProfileViewModel+Mock.swift
//  MKR-CleanSwift
//
//  Created by Dmitriy Permyakov on 11.12.2024.
//

import Foundation
import UIKit

@Observable
final class ProfileViewModelMock: ProfileDisplayLogic {
    private(set) var profile: Profile?
    private(set) var showLoading: Bool
    private(set) var delay: TimeInterval

    init(
        delay: TimeInterval,
        profile: Profile? = nil,
        showLoading: Bool = false
    ) {
        self.delay = delay
        self.profile = profile
        self.showLoading = showLoading
    }

    func onAppear() {
        showLoading = true
        Task { @MainActor in
            try? await Task.sleep(for: .seconds(delay))
            showLoading = false
            self.profile = .mockData
        }
    }

    func didTapUpdateButton() {
        showLoading = true
        Task { @MainActor in
            try? await Task.sleep(for: .seconds(delay))
            profile = .init(name: "updated title", status: "updated status", imageData: UIImage.anime2.pngData())
            showLoading = false
        }
    }
}
