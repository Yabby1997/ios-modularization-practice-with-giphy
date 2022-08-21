//
//  DependencyContainer.swift
//  Giphy
//
//  Created by USER on 2022/08/21.
//

import Foundation
import GiphySearchPresentationLayer
import GiphyDomainLayer
import GiphyDataLayer
import URLRequestDataLayer
import URLRequestDataSourceLayer

import Swinject

extension Container {
    static let shared: Container = {
        let container = Container()

        container.register(URLRequestBuilderNetworkServiceProtocol.self) { _ in
            URLRequestBuilderNetworkService()
        }

        container.register(GiphyRepositoryProtocol.self) { resolver in
            GiphyRepository(
                apiKey: "rEDEvI1fNspJPNdMNscfdzwLsC3zZRx5",
                networkService: resolver.resolve(URLRequestBuilderNetworkServiceProtocol.self)!
            )
        }

        container.register(GiphyUseCaseProtocol.self) { resolver in
            GiphyUseCase(repository: resolver.resolve(GiphyRepositoryProtocol.self)!)
        }

        container.register(GiphySearchViewModel.self) { resolver in
            GiphySearchViewModel(giphyUseCase: resolver.resolve(GiphyUseCaseProtocol.self)!)
        }

        container.register(GiphySearchViewController.self) { resolver in
            GiphySearchViewController(viewModel: resolver.resolve(GiphySearchViewModel.self)!)
        }

        return container
    }()
}
