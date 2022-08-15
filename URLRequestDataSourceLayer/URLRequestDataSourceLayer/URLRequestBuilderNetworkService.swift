//
//  URLRequestBuilderNetworkService.swift
//  URLRequestDataSourceLayer
//
//  Created by USER on 2022/08/14.
//

import URLRequestDataLayer

public final class URLRequestBuilderNetworkService: URLRequestBuilderNetworkServiceProtocol {

    enum Errors: LocalizedError {
        case requestFailed
        case invalidStatusCode(code: Int?)

        var errorDescription: String? {
            switch self {
            case .requestFailed: return "request failed"
            case .invalidStatusCode(let code): return "invalid status code: \(code ?? -1)"
            }
        }
    }

    private let cache = URLCache()

    public init() { }

    public func request<DTO: Decodable>(with builder: URLRequestBuilder) async throws -> (DTO, URLResponse) {
        let request = try builder.build()
        let result: (data: Data, response: URLResponse) = try await URLSession.shared.data(for: request)
        let dataTransferObject = try JSONDecoder().decode(DTO.self, from: result.data)
        return (dataTransferObject, result.response)
    }

    public func download(with builder: URLRequestBuilder) async throws -> Data {
        let request = try builder.build()

        return try await withUnsafeThrowingContinuation { continuation in
            let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                    continuation.resume(throwing: Errors.requestFailed)
                    return
                }
                guard 200...300 ~= statusCode else {
                    continuation.resume(throwing: Errors.invalidStatusCode(code: statusCode))
                    return
                }
                guard let data = data else {
                    continuation.resume(throwing: Errors.requestFailed)
                    return
                }
                continuation.resume(returning: data)
            }

            cache.getCachedResponse(for: dataTask) { cachedResponse in
                if let cachedResponse = cachedResponse {
                    continuation.resume(returning: cachedResponse.data)
                    return
                }
                dataTask.resume()
            }
        }
    }
}
