//
//  MainTabBarController.swift
//  RickAndMorty
//
//  Created by Anastasiya Omak on 01/01/2024.
//

import UIKit

class MainTabBarController: UITabBarController {
    // MARK: - Private Property
    private let titleBar = TitleBar()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.itemPositioning = .centered
        generateTabBar()
        setTabBarAppearance()
    }
    
    // MARK: - Private Method
    private func generateTabBar() {
        viewControllers = [
            generateVC(viewController: HomeViewController(), title: titleBar.homeTitle, image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill")),
            generateVC(viewController: FavoriteViewController(), title: titleBar.bookmarkTitle, image: UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart.fill")),
        ]
    }
    
    private func generateVC(viewController: UIViewController, title: String, image: UIImage?, selectedImage: UIImage?) -> UIViewController {
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = image
        navigationController.tabBarItem.selectedImage = selectedImage
        navigationController.tabBarItem.titlePositionAdjustment = .init(horizontal: -3, vertical: 0)
        
        return navigationController
    }
    
    private func setTabBarAppearance() {
        tabBar.tintColor = .systemRed
        tabBar.unselectedItemTintColor = .systemBlue
        tabBar.backgroundColor = .white
    }
}

// MARK: - Constants
extension MainTabBarController {
    private struct TitleBar {
        let homeTitle = "Home"
        let bookmarkTitle = "Favorite"
    }
}

