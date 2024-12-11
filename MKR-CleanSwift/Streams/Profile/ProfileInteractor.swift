//
//  ProfileInteractor.swift
//  MKR-CleanSwift
//
//  Created by Dmitriy Permyakov on 11.12.2024.
//

import Foundation

final class ProfileInteractor: ProfileInteractorInput {
    var presenter: ProfilePresenterInput?
    private let catService: CatImageServiceProtocol

    init(catService: CatImageServiceProtocol) {
        self.catService = catService
    }
}

// MARK: - ProfileInteractorInput

extension ProfileInteractor {
    func getProfileInfo() {
        obtainProfile(title: "Dmitriy Permyakov", status: "student")
    }

    func updateProfileInfo(request: ProfileModel.Request) {
        obtainProfile(title: request.profile.name + " updated", status: request.profile.status + " [changed]")
    }
}

// MARK: - Helpers

private extension ProfileInteractor {
    func obtainProfile(title: String, status: String) {
        Task {
            do {
                let imageData = try await catService.randomCatImage()
                let profile = Profile(name: title, status: status, imageData: imageData)
                await validate(result: .success(profile))
            } catch {
                let networkError: NetworkError
                switch error {
                case let error as NetworkError:
                    networkError = error
                default:
                    networkError = .customError(error)
                }
                await validate(result: .failure(networkError))
            }
        }
    }

    func validate(result: Result<Profile, NetworkError>) async {
        await MainActor.run {
            self.presenter?.presentProfileInfo(response: .getImageCat(result))
        }
    }
}
