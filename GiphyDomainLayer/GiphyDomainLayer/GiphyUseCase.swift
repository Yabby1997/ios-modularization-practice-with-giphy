//
//  GiphyUseCase.swift
//  GiphyDomainLayer
//
//  Created by USER on 2022/08/14.
//

import Foundation

public protocol GiphyUseCaseProtocol {
    func search(query: String) async throws -> [GiphyEntity]
}

final public class GiphyUseCase: GiphyUseCaseProtocol {

    private let repository: GiphyRepositoryProtocol

    public init(repository: GiphyRepositoryProtocol) {
        self.repository = repository
    }

    public func search(query: String) async throws -> [GiphyEntity] {
        try await repository.search(query: query)
    }
}
