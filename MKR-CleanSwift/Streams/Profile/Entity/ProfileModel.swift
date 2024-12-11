//
//  ProfileModel.swift
//  MKR-CleanSwift
//
//  Created by Dmitriy Permyakov on 11.12.2024.
//

import Foundation

enum ProfileModel {
    struct Request {
        let profile: Profile
    }
    enum Response {
        case getImageCat(Result<Profile, NetworkError>)
    }
}
