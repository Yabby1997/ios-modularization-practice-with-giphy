//
//  SceneDelegate.swift
//  Giphy
//
//  Created by USER on 2022/08/14.
//

import UIKit
import GiphySearchPresentationLayer
import GiphyDomainLayer
import GiphyDataLayer
import URLRequestDataSourceLayer

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = GiphySearchViewController(
            viewModel: GiphySearchViewModel(
                giphyUseCase: GiphyUseCase(
                    repository: GiphyRepository(
                        apiKey: "rEDEvI1fNspJPNdMNscfdzwLsC3zZRx5",
                        networkService: URLRequestBuilderNetworkService()
                    )
                )
            )
        )

        window?.makeKeyAndVisible()
    }
}
