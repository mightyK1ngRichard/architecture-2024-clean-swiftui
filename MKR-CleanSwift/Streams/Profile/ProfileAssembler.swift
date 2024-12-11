//
//  ProfileAssembler.swift
//  MKR-CleanSwift
//
//  Created by Dmitriy Permyakov on 11.12.2024.
//

import Foundation

final class ProfileAssembler {
    static func assemble() -> ProfileViewModel {
        let presenter = ProfilePresenter()
        let catService = CatImageServiceImpl()
        let interactor = ProfileInteractor(catService: catService)
        interactor.presenter = presenter
        let viewModel = ProfileViewModel()
        viewModel.interactor = interactor
        presenter.viewModel = viewModel

        return viewModel
    }
}
