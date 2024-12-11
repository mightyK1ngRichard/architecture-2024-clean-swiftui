//
//  ProfilePresenter.swift
//  MKR-CleanSwift
//
//  Created by Dmitriy Permyakov on 11.12.2024.
//

import Foundation

final class ProfilePresenter: ProfilePresenterInput {
    weak var viewModel: ProfileDisplayLogicInput?

    func presentProfileInfo(response: ProfileModel.Response) {
        switch response {
        case let .getImageCat(result):
            getImageCat(result: result)
        }
    }
}

// MARK: - Helpers

private extension ProfilePresenter {
    func getImageCat(result: Result<Profile, NetworkError>) {
        switch result {
        case let .success(profile):
            viewModel?.presentProfileInfo(profile: profile)
        case let .failure(networkError):
            viewModel?.presentProfileError(errorMessage: networkError.localizedDescription)
        }
    }
}
