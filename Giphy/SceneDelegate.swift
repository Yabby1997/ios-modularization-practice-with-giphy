//
//  SceneDelegate.swift
//  Giphy
//
//  Created by USER on 2022/08/14.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = UIViewController()
        window?.rootViewController?.view.backgroundColor = .yellow
        window?.makeKeyAndVisible()
    }
}

