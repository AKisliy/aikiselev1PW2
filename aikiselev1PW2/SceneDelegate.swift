//
//  SceneDelegate.swift
//  aikiselev1PW2
//
//  Created by Alexey Kiselev on 24.09.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = WishMakerViewController()
        self.window = window
        window.makeKeyAndVisible()
        
    }
}

