//
//  ProfileView.swift
//  MKR-CleanSwift
//
//  Created by Dmitriy Permyakov on 11.12.2024.
//

import SwiftUI

struct ProfileView: View {
    @State var viewModel: ProfileDisplayLogic

    var body: some View {
        mainContainer.onAppear(perform: viewModel.onAppear)
    }
}

// MARK: - Preview

#Preview("Mockable") {
    ProfileView(viewModel: ProfileViewModelMock(delay: 2))
}

#Preview {
    ProfileView(viewModel: ProfileAssembler.assemble())
}
