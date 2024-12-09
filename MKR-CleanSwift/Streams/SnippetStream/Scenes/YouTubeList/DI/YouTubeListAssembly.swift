//
//  YouTubeListAssembly.swift
//  MKR-CleanSwift
//
//  Created by Dmitriy Permyakov on 07.12.2024.
//

import Foundation

final class YouTubeListAssembly {
    static let shared = YouTubeListAssembly()
    private init() {}

    func build() -> YouTubeListViewModel {
        let webRepository = YouTubeListWebRepositoryImpl()
        let presenter = YouTubeListPresenter()
        let imageLoaderService = ImageLoader()
        let interactor = YouTubeListInteractor(
            webRepository: webRepository,
            imageLoaderService: imageLoaderService
        )
        interactor.presenter = presenter
        let viewModel = YouTubeListViewModel()
        viewModel.interactor = interactor
        presenter.viewModel = viewModel
        return viewModel
    }
}
