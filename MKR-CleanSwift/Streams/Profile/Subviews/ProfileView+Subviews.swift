//
//  ProfileView+Subviews.swift
//  MKR-CleanSwift
//
//  Created by Dmitriy Permyakov on 11.12.2024.
//

import SwiftUI

extension ProfileView {

    var mainContainer: some View {
        VStack(spacing: 16) {
            userImageView
            profileInfo
            Spacer()
        }
        .overlay(alignment: .bottom) {
            Button("Update", action: viewModel.didTapUpdateButton)
                .buttonStyle(.borderedProminent)
        }
        .overlay {
            if viewModel.showLoading {
                ProgressView()
            }
        }
    }

    @ViewBuilder
    var userImageView: some View {
        if let imageData = viewModel.profile?.imageData, let uiImage = UIImage(data: imageData) {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFill()
                .frame(width: 150, height: 150)
                .clipShape(.circle)
        } else {
            Circle()
                .fill(.ultraThinMaterial)
                .frame(width: 150, height: 150)
                .overlay {
                    Image(systemName: "person")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32)
                }
        }
    }

    var profileInfo: some View {
        VStack(spacing: 5) {
            if let profile = viewModel.profile {
                Text(profile.name)
                    .font(.headline)
                    .foregroundStyle(.primary)
                Text(profile.status)
                    .font(.callout)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

// MARK: - Preview

#Preview("Mockable") {
    ProfileView(viewModel: ProfileViewModelMock(delay: 2))
}

#Preview("Network") {
    ProfileView(viewModel: ProfileAssembler.assemble())
}
