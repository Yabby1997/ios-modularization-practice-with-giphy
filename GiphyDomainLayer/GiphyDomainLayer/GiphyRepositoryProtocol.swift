//
//  GiphyRepositoryProtocol.swift
//  GiphyDomainLayer
//
//  Created by USER on 2022/08/14.
//

import Foundation

public protocol GiphyRepositoryProtocol {
    func search(query: String) async throws -> [GiphyEntity]
}
