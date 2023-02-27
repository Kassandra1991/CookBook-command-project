//
//  SceneDelegate.swift
//  СookBook
//
//  Created by Alex on 26.02.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.windowScene = windowScene
        window?.makeKeyAndVisible()
        window?.rootViewController = createTabBarController()
        
        
        func createTabBarController() -> UITabBarController {
            let tabBarController = UITabBarController()
            UITabBar.appearance().backgroundColor = .systemBackground
            tabBarController.viewControllers = [createFavoriteViewController(), createSearchViewController()]
            return tabBarController
        }
        
        func createFavoriteViewController() -> UINavigationController {
            let favoriteViewController = FavoriteViewController()
            favoriteViewController.title = "Favorite"
            favoriteViewController.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage(systemName: "Star"), tag: 0)
            return UINavigationController(rootViewController: favoriteViewController)
        }
        
        func createSearchViewController() -> UINavigationController {
            let searchViewController = SearchViewController()
            searchViewController.title = "Search"
            searchViewController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "Search"), tag: 1)
            return UINavigationController(rootViewController: searchViewController)
        }
    }
}

