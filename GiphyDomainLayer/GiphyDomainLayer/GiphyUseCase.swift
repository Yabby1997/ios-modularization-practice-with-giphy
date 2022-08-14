//
//  GiphyUseCase.swift
//  GiphyDomainLayer
//
//  Created by USER on 2022/08/14.
//

import Foundation

final public class GiphyUseCase {

    private let repository: GiphyRepositoryProtocol

    init(repository: GiphyRepositoryProtocol) {
        self.repository = repository
    }

    func search(query: String) async throws -> [GiphyEntity] {
        try await repository.search(query: query)
    }
}
