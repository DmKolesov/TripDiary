//
//  SceneDelegate.swift
//  TripDiary
//
//  Created by TX 3000 on 08.07.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }

        let window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController()
        
        let tripConfigurator: TripConfiguratorProtocol = TripConfigurator()
        if let tripVC = tripConfigurator.configureTripViewController() as? UIViewController {
            navigationController.viewControllers = [tripVC]
            window.rootViewController = navigationController
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}
