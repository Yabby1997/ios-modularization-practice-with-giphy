//
//  URLRequestBuilderNetworkServiceProtocol.swift
//  URLRequestDataLayer
//
//  Created by USER on 2022/08/14.
//

import Foundation

public protocol URLRequestBuilderNetworkServiceProtocol {
    func request(with builder: URLRequestBuilder) async throws -> (Data, URLResponse)
}
