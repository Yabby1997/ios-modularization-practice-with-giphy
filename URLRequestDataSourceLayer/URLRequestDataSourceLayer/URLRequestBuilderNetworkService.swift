//
//  URLRequestBuilderNetworkService.swift
//  URLRequestDataSourceLayer
//
//  Created by USER on 2022/08/14.
//

import URLRequestDataLayer

public final class URLRequestBuilderNetworkService: URLRequestBuilderNetworkServiceProtocol {

    public init() { }

    public func request<DTO: Decodable>(with builder: URLRequestBuilder) async throws -> (DTO, URLResponse) {
        let request = try builder.build()
        let result: (data: Data, response: URLResponse) = try await URLSession.shared.data(for: request)
        let dataTransferObject = try JSONDecoder().decode(DTO.self, from: result.data)
        return (dataTransferObject, result.response)
    }
}
