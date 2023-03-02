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
        let startVC = ViewController()
                self.window?.rootViewController = startVC
                window?.makeKeyAndVisible()
                window?.windowScene = windowScene
//        window?.windowScene = windowScene
//        let startVc = ViewController()
//        let navigation = UINavigationController(rootViewController: startVc)
//        window?.makeKeyAndVisible()
//        window?.rootViewController = ViewController()
       
        
        
//        func createTabBarController() -> UITabBarController {
//            let tabBarController = UITabBarController()
//            UITabBar.appearance().backgroundColor = .systemBackground
//            tabBarController.viewControllers = [createSearchViewController(), createFavoriteViewController()]
//            return tabBarController
//        }
//        
//        func createFavoriteViewController() -> UINavigationController {
//            let favoriteViewController = FavoriteViewController()
//            favoriteViewController.title = "Favorite"
//            favoriteViewController.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage(systemName: "Star"), tag: 0)
//            return UINavigationController(rootViewController: favoriteViewController)
//        }
//        
//        func createSearchViewController() -> UINavigationController {
//            let mainViewController = MainViewController()
//            mainViewController.title = "Main"
//            mainViewController.tabBarItem = UITabBarItem(title: "Main", image: UIImage(systemName: "Search"), tag: 1)
//            return UINavigationController(rootViewController: mainViewController)
//        }
    }
}

