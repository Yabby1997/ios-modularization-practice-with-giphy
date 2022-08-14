//
//  GiphyRepository.swift
//  GiphyDataLayer
//
//  Created by USER on 2022/08/14.
//

import GiphyDomainLayer
import URLRequestDataLayer

public final class GiphyRepository: GiphyRepositoryProtocol {

    private let apiKey: String
    private let networkService: URLRequestBuilderNetworkServiceProtocol

    public init(
        apiKey: String,
        networkService: URLRequestBuilderNetworkServiceProtocol
    ) {
        self.apiKey = apiKey
        self.networkService = networkService
    }

    public func search(query: String) async throws -> [GiphyEntity] {
        let result: (dataTransferObject: GiphySearchResultDataTransferObject, response: URLResponse) = try await networkService.request(
            with: GiphyRequestBuilder.search(
                key: apiKey,
                query: query
            )
        )

        return result.dataTransferObject.data.compactMap {
            GiphyEntity(
                name: $0.title,
                thumbnailUrl: $0.images.thumbnail,
                originalUrl: $0.images.original
            )
        }
    }
}
