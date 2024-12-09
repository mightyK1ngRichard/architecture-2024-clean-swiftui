////
////  AsyncStreamImages.swift
////  MKR-CleanSwift
////
////  Created by Dmitriy Permyakov on 08.12.2024.
////
//
//import SwiftUI
//
//struct AsyncStreamImages: View {
//    @State var vm = ViewModel()
//    @State var title = "none"
//
//    var body: some View {
//        ScrollView {
//            Text(title)
//            HStack {
//                Button("Get images") {
//                    vm.start()
//                }
//                .buttonStyle(.borderedProminent)
//
//                Button("Cancel") {
//                    vm.stop()
//                    title = "STOPED"
//                }
//                .buttonStyle(.bordered)
//            }
//            .padding()
//
//            LazyVStack {
//                ForEach(vm.images, id: \.hashValue) { uiImage in
//                    Image(uiImage: uiImage)
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                        .frame(height: 150)
//                        .clipShape(.rect(cornerRadius: 12))
//                        .padding(.horizontal)
//                }
//            }
//        }
//    }
//}
//
//@Observable
//final class ViewModel {
//    @ObservationIgnored
//    var task: Task<Void, Never>?
//    var images: [UIImage] = []
//    @ObservationIgnored
//    let imageLoader = ImageLoader()
//
//    func start() {
//        print("[DEBUG]: start task")
//        guard task == nil else { return }
//        print("[DEBUG]: start request")
//        task = Task {
//            do {
//                let result = try await self.imageLoader.getImages(urlsWithIDs: self.req)
//                let uiImages = result.compactMap {
//                    switch $0.1 {
//                    case let .success(data):
//                        return UIImage(data: data)
//                    case .failure:
//                        return nil
//                    }
//                }
//                await MainActor.run {
//                    self.images = uiImages
//                }
//            } catch {
//                if let error = error as? ImageLoader.ImageLoaderError {
//                    print("[DEBUG]: \(error.description)")
//                }
//            }
//        }
//    }
//
//    func stop() {
//        task?.cancel()
//        task = nil
//    }
//
//    let req: [(String, URL)] = (1...1200).compactMap {
//        guard
//            let url = URL(string: "https://avatars.mds.yandex.net/i?id=571c0b58b275279445345735ef32745e_l-5229934-images-thumbs&n=\(Int.random(in: 1...14))")
//        else { return nil }
//        return (String($0), url)
//    }
//}
//
//#Preview {
//    AsyncStreamImages()
//}
