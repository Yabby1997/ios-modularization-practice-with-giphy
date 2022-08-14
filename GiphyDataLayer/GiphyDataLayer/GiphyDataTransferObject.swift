//
//  GiphyDataTransferObject.swift
//  GiphyDataLayer
//
//  Created by USER on 2022/08/14.
//

import Foundation

struct GiphySearchResultDataTransferObject: Decodable {
    let data: [GiphyDataTransferObject]
}

struct GiphyDataTransferObject: Decodable {
    let id: String
    let title: String
    let source: String
    let images: GiphyImageDataTransferObject
}

struct GiphyImageDataTransferObject: Decodable {
    let original: URL?
    let thumbnail: URL?

    enum CodingKeys: String, CodingKey {
        case original = "original"
        case thumbnail = "downsized"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let originalUrl = try container.decode(GiphyURLDataTransferObject.self, forKey: .original)
        let thumbnailUrl = try container.decode(GiphyURLDataTransferObject.self, forKey: .thumbnail)
        self.original = originalUrl.url
        self.thumbnail = thumbnailUrl.url
    }
}

struct GiphyURLDataTransferObject: Decodable {
    let url: URL?

    enum CodingKeys: String, CodingKey {
        case url = "url"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let stringUrl = try container.decode(String.self, forKey: .url)
        self.url = URL(string: stringUrl)
    }
}
