//
//  URLRequestBuilderNetworkService.swift
//  URLRequestDataSourceLayer
//
//  Created by USER on 2022/08/14.
//

import URLRequestDataLayer

final public class URLRequestBuilderNetworkService: URLRequestBuilderNetworkServiceProtocol {
    public func request(with builder: URLRequestBuilder) async throws -> (Data, URLResponse) {
        let request = try builder.build()
        return try await URLSession.shared.data(for: request)
    }
}
