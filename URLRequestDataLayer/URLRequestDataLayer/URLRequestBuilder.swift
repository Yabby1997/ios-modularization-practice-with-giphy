//
//  URLRequestBuilder.swift
//  URLRequestDataLayer
//
//  Created by USER on 2022/08/14.
//

import Foundation

public enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

public enum URLRequestBuilderErrors: LocalizedError {
    case failedToBuildRequest

    public var errorDescription: String? {
        switch self {
        case .failedToBuildRequest: return "failed to build request"
        }
    }
}

public protocol URLRequestBuilder {
    var domain: String { get }
    var path: String? { get }
    var method: HTTPMethods { get }
    var headers: [String: String]? { get }
    var parameters: [String: String?]? { get }
    var body: [String: Any]? { get }
    func build() throws -> URLRequest
}

extension URLRequestBuilder {
    public func build() throws -> URLRequest {
        guard let url = URL(string: domain + (path ?? "")) else { throw URLRequestBuilderErrors.failedToBuildRequest }
        var urlRequest: URLRequest

        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = parameters?.compactMap { key, value in
            guard let value = value, !key.isEmpty else { return nil }
            return URLQueryItem(name: key, value: value)
        } ?? []

        if let urlWithQueryItems = urlComponents?.url {
            urlRequest = URLRequest(url: urlWithQueryItems)
        }
        else {
            urlRequest = URLRequest(url: url)
        }

        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers

        if let body = body {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }

        return urlRequest
    }
}
