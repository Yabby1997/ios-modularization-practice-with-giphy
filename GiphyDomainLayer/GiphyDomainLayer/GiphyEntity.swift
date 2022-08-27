//
//  GiphyEntity.swift
//  
//
//  Created by USER on 2022/08/14.
//

import Foundation

public struct GiphyEntity {
    public let name: String
    public let thumbnailUrl: URL?
    public let originalUrl: URL?

    public init(
        name: String,
        thumbnailUrl: URL?,
        originalUrl: URL?
    ) {
        self.name = name
        self.thumbnailUrl = thumbnailUrl
        self.originalUrl = originalUrl
    }
}
