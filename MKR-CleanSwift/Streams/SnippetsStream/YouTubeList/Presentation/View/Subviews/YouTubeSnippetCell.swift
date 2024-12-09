//
//  YouTubeSnippetCell.swift
//  MKR-CleanSwift
//
//  Created by Dmitriy Permyakov on 07.12.2024.
//

import SwiftUI

struct YouTubeSnippetCell: View {

    let configuration: Configuration
    var body: some View {
        VStack(alignment: .leading) {
            Text(configuration.title)
                .font(.subheadline)
            imageView
        }
        .padding()
        .background(.background, in: .rect(cornerRadius: 16))
    }
}

// MARK: - UI Subviews

private extension YouTubeSnippetCell {

    @ViewBuilder
    var imageView: some View {
        switch configuration.imageState {
        case .loading:
            shimmeringView
        case .error:
            RoundedRectangle(cornerRadius: 8)
                .fill(.ultraThinMaterial)
                .frame(height: 200)
                .overlay {
                    Image(systemName: "photo.badge.exclamationmark")
                }
        case let .loaded(imageKind):
            imageKindView(for: imageKind)
        }
    }

    @ViewBuilder
    func imageKindView(for imageKind: ImageKind) -> some View {
        switch imageKind {
        case let .url(url):
            AsyncImage(url: url) { image in
                makeImageView(image: image)
            } placeholder: {
                shimmeringView
            }

        case let .data(data):
            if let uiImage = UIImage(data: data) {
                makeImageView(image: Image(uiImage: uiImage))
            } else {
                RoundedRectangle(cornerRadius: 8)
                    .fill(.ultraThinMaterial)
                    .frame(height: 200)
            }
        case let .uiImage(uiImage):
            makeImageView(image: Image(uiImage: uiImage))
        }
    }

    func makeImageView(image: Image) -> some View {
        image
            .resizable()
            .scaledToFill()
            .frame(height: 200)
            .clipShape(.rect(cornerRadius: 8))
    }

    var shimmeringView: some View {
        ShimmeringView()
            .frame(height: 200)
            .clipShape(.rect(cornerRadius: 8))
    }
}

// MARK: - Configuration

extension YouTubeSnippetCell {

    struct Configuration: Hashable, Equatable {
        let title: String
        let imageState: ImageState
    }
}

// MARK: - Preview

#Preview {
    YouTubeSnippetCell(
        configuration: .init(
            title: "Title",
            imageState: .loaded(
                .uiImage(UIImage(resource: .anime1))
            )
        )
    )
    .padding(.horizontal)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.bar)
}
