//
//  SceneDelegate.swift
//  SearchTheMovie
//
//  Created by Alex Chernokun on 08.04.2020.
//  Copyright © 2020 Alex Chernokun. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController()
        let vc = SearchMovieViewController()
        window.rootViewController = navigationController
        navigationController.viewControllers = [vc]
        self.window = window
        window.makeKeyAndVisible()
    }
    
}

