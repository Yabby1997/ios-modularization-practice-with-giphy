//
//  GiphySearchViewModel.swift
//  GiphySearchPresentationLayer
//
//  Created by USER on 2022/08/14.
//

import Foundation
import GiphyDomainLayer

public final class GiphySearchViewModel {

    @Published var images: [GiphyEntity] = []

    private let giphyUseCase: GiphyUseCaseProtocol

    public init(giphyUseCase: GiphyUseCaseProtocol) {
        self.giphyUseCase = giphyUseCase
    }

    func didLoad() {
        Task { [weak self] in
            do {
                let images = try await giphyUseCase.search(query: "spongebob")
                self?.images.append(contentsOf: images)
                print(images)
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
}
