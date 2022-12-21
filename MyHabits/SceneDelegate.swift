//
//  SceneDelegate.swift
//  MyHabits
//
//  Created by Artyom Prima on 02.11.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let habitsVC = HabitsViewController()
        let infoVC = InfoViewController()
        let navHabitsVC = UINavigationController(rootViewController: habitsVC)
        let navInfoVC = UINavigationController(rootViewController: infoVC)
        let tabBarController = UITabBarController()
        tabBarController.tabBar.backgroundColor = .white
        UITabBar.appearance().tintColor = #colorLiteral(red: 0.6329703331, green: 0.08420988172, blue: 0.8011942506, alpha: 1)
        tabBarController.viewControllers = [navHabitsVC, navInfoVC]
        navHabitsVC.tabBarItem = UITabBarItem(title: "Привычки",
                                            image: UIImage(systemName: "square.text.square"),
                                            selectedImage: UIImage(systemName: "square.text.square.fill"))
        navInfoVC.tabBarItem = UITabBarItem(title: "Информация",
                                            image: UIImage(systemName: "questionmark.folder"),
                                            selectedImage: UIImage(systemName: "questionmark.fill"))
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        window?.overrideUserInterfaceStyle = .light
 
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}

