//
//  GiphySearchViewModel.swift
//  GiphySearchPresentationLayer
//
//  Created by USER on 2022/08/14.
//

import Foundation
import GiphyDomainLayer

public final class GiphySearchViewModel {

    private let giphyUseCase: GiphyUseCase

    public init(giphyUseCase: GiphyUseCase) {
        self.giphyUseCase = giphyUseCase
    }

    func didLoad() async throws -> [GiphyEntity] {
        return try await giphyUseCase.search(query: "spongebob")
    }
}
