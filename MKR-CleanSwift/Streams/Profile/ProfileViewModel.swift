//
//  ProfileViewModel.swift
//  MKR-CleanSwift
//
//  Created by Dmitriy Permyakov on 11.12.2024.
//

import Foundation
import UIKit
import Observation

@Observable
final class ProfileViewModel: ProfileDisplayLogic, ProfileDisplayLogicInput {
    @ObservationIgnored
    var interactor: ProfileInteractorInput?

    private(set) var profile: Profile?
    private(set) var showLoading: Bool
    private(set) var errorMessage: String?

    init(
        profile: Profile? = nil,
        showLoading: Bool = false,
        errorMessage: String? = nil
    ) {
        self.profile = profile
        self.showLoading = showLoading
        self.errorMessage = errorMessage
    }
}

// MARK: - ProfileDisplayLogicInput

extension ProfileViewModel {
    func presentProfileInfo(profile: Profile) {
        self.profile = profile
        showLoading = false
    }

    func presentProfileError(errorMessage: String) {
        self.errorMessage = errorMessage
        showLoading = false
    }
}

// MARK: - ProfileDisplayLogicOutput

extension ProfileViewModel {
    func onAppear() {
        showLoading = true
        fetchData()
    }

    func didTapUpdateButton() {
        guard let profile else { return }
        showLoading = true
        interactor?.updateProfileInfo(request: .init(profile: profile))
    }
}

// MARK: - Helpers

private extension ProfileViewModel {

    func fetchData() {
        interactor?.getProfileInfo()
    }
}
