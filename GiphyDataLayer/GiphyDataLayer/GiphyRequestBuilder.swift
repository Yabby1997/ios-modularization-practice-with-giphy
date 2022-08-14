//
//  GiphyRequestBuilder.swift
//  GiphyDataLayer
//
//  Created by USER on 2022/08/14.
//

import URLRequestDataLayer

enum GiphyRequestBuilder: URLRequestBuilder {
    case search(
        key: String,
        query: String,
        limitCount: Int = 20,
        pageOffset: Int = 0,
        rating: String? = nil,
        language: String? = nil
    )

    enum ParameterKey {
        static let apiKey = "api_key"
        static let query = "q"
        static let limitCount = "limit"
        static let pageOffset = "offset"
        static let rating = "rating"
        static let language = "language"
    }

    var domain: String { "https://api.giphy.com/v1/gifs" }

    var path: String {
        switch self {
        case .search: return "/search"
        }
    }

    var method: HTTPMethods {
        switch self {
        case .search: return .get
        }
    }

    var headers: [String : String]? { nil }

    var parameters: [String : String?]? {
        switch self {
        case .search(
            let key,
            let query,
            let limitCount,
            let pageOffset,
            let rating,
            let language
        ):
            return [
                ParameterKey.apiKey: key,
                ParameterKey.query: query,
                ParameterKey.limitCount: "\(limitCount)",
                ParameterKey.pageOffset: "\(pageOffset)",
                ParameterKey.rating: rating,
                ParameterKey.language: language
            ]
        }
    }

    var body: [String : Any]? { nil }
}
