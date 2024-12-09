//
//  YouTubeListView.swift
//  MKR-CleanSwift
//
//  Created by Dmitriy Permyakov on 07.12.2024.
//

import SwiftUI

struct YouTubeList: View {
    @State var viewModel: YouTubeListDisplayLogic

    var body: some View {
        NavigationStack {
            contentContainer.navigationTitle("YouTube")
        }
        .onAppear(perform: viewModel.fetch)
    }
}

// MARK: - UI Subviews

private extension YouTubeList {

    @ViewBuilder
    var contentContainer: some View {
        switch viewModel.screenState {
        case .initial, .loading:
            ProgressView()
        case .loaded:
            snippetsView
        case let .error(errorMessage):
            Text("Error")
            Text(errorMessage)
        }
    }

    var snippetsView: some View {
        List {
            ForEach(viewModel.snippets) { snippet in
                YouTubeSnippetCell(
                    configuration: viewModel.makeConfiguration(from: snippet)
                )
            }
            .onDelete(perform: viewModel.deleteSnippet)
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
        }
        .listStyle(.plain)
        .background(.bar)
    }
}

// MARK: - Preview

#Preview("Mockable") {
    YouTubeList(viewModel: YouTubeListViewModelMock(delay: 2))
}

#Preview("Mockable Error") {
    YouTubeList(
        viewModel: YouTubeListViewModelMock(
            delay: 1,
            screenState: .error("Просто какая-то ошибка")
        )
    )
}

#Preview("Network") {
    YouTubeList(viewModel: YouTubeListAssembly.shared.build())
}
