//
//  TabBar.swift
//  СookBook
//
//  Created by Admin on 1.03.23.
//

import UIKit

final class  TabBar: UITabBarController{
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        UITabBar.appearance().barTintColor = .blue
        tabBar.tintColor = .label
        setupVCs()
    }
    private func setupVCs() {
            viewControllers = [
                createNavController(for: MainViewController(), title: NSLocalizedString("Main", comment: ""), image: UIImage(systemName: "house")!),
                createNavController(for: FavoriteViewController(), title: NSLocalizedString("Favorite", comment: ""), image: UIImage(systemName: "star")!)
            ]
        }
    fileprivate func createNavController(for rootViewController: UIViewController,
                                                     title: String,
                                                     image: UIImage) -> UIViewController {
           let navController = UINavigationController(rootViewController: rootViewController)
           navController.tabBarItem.title = title
           navController.tabBarItem.image = image
           navController.navigationBar.prefersLargeTitles = true
           navController.modalPresentationStyle = .overCurrentContext
           rootViewController.navigationItem.title = title
           return navController
       }
}

