//
//  ProfileProtocols.swift
//  MKR-CleanSwift
//
//  Created by Dmitriy Permyakov on 11.12.2024.
//

import Foundation

// MARK: - ViewModel

protocol ProfileDisplayLogic: ProfileDisplayLogicOutput {
    var profile: Profile? { get }
    var showLoading: Bool { get }
}

protocol ProfileDisplayLogicInput: AnyObject {
    func presentProfileInfo(profile: Profile)
    func presentProfileError(errorMessage: String)
}

protocol ProfileDisplayLogicOutput: AnyObject {
    func onAppear()
    func didTapUpdateButton()
}

// MARK: - Input

protocol ProfileInteractorInput: AnyObject {
    func getProfileInfo()
    func updateProfileInfo(request: ProfileModel.Request)
}

// MARK: - Presenter

protocol ProfilePresenterInput: AnyObject {
    func presentProfileInfo(response: ProfileModel.Response)
}
