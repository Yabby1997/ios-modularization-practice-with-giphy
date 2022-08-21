//
//  SceneDelegate.swift
//  Giphy
//
//  Created by USER on 2022/08/14.
//

import UIKit
import GiphySearchPresentationLayer

import Swinject

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = Container.shared.resolve(GiphySearchViewController.self)
        window?.makeKeyAndVisible()
    }
}
