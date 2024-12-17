//
//  SceneDelegate.swift
//  recap
//
//  Created by Diptayan Jash on 05/11/24.
//

import UIKit

protocol PatientInfoDelegate: AnyObject {
    func didCompleteProfile()
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate, PatientInfoDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
//        window.rootViewController = TabbarViewController()
        let launchVC = launchScreenViewController()
        
//        if UserDefaultsStorageProfile.shared.isLoggedIn() {
//                // User is logged in, show the main tab bar controller
//                let tabBarVC = TabbarViewController()
//                window.rootViewController = tabBarVC
//            } else {
//                // User is not logged in, show the welcome screen
//                let welcomeVC = WelcomeViewController()
//                let navigationController = UINavigationController(rootViewController: welcomeVC)
//                window.rootViewController = navigationController
//            }
        window.rootViewController = launchVC
        self.window = window
        window.makeKeyAndVisible()

//        let questionItem = UIApplicationShortcutItem(
//            type: "daily-questions",
//            localizedTitle: "Daily Questions",
//            localizedSubtitle: "Answer today's questions",
//            icon: UIApplicationShortcutIcon(systemImageName: "questionmark.circle.fill")
//        )
//        let familyItem = UIApplicationShortcutItem(
//            type: "family-members",
//            localizedTitle: "Family Members",
//            localizedSubtitle: "View family members",
//            icon: UIApplicationShortcutIcon(systemImageName: "person.3.fill")
//            )
//
//
//        UIApplication.shared.shortcutItems = [questionItem, familyItem]
    }

    func didCompleteProfile() {
        let tabBar = TabbarViewController()
        UIView.transition(with: window!,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: {
                              self.window?.rootViewController = tabBar
                          })
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}
