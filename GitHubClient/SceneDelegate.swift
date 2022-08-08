//
//  SceneDelegate.swift
//  GitHubClient
//
//  Created by TeRb1 on 07.08.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        setupWindow(scene: scene)
    }
    
    
    //Создаем окно, которое у нас будет отображаться при запуске приложения
    private func setupWindow(scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let controller = ViewController()
        window?.rootViewController = controller
        window?.overrideUserInterfaceStyle = .light
        window?.makeKeyAndVisible()
    }
}

