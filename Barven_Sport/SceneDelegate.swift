//
//  SceneDelegate.swift
//  Barven_Sport
//
//  Created by Nguyễn Minh Hiếu on 5/27/20.
//  Copyright © 2020 Nguyễn Minh Hiếu. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
//           NotificationCenter.default.addObserver(self, selector: #selector(launch), name: UIDevice.orientationDidChangeNotification, object: nil)
        guard let _ = (scene as? UIWindowScene) else { return }
    }
    var storyboard : UIStoryboard?
    var initVC: UIViewController!
    var initlaunch : UIViewController!
    var launchScreen : UIStoryboard?
    
    @objc func rotated(){
        if UIDevice.current.orientation.isLandscape {
            storyboard = UIStoryboard.init(name: "MainLandscape", bundle: nil)
            initVC = storyboard?.instantiateViewController(withIdentifier: "PositionLandscapeViewController") as! PositionLandscapeViewController
        }

        if UIDevice.current.orientation.isPortrait {
            storyboard = UIStoryboard.init(name: "MainPortrait", bundle: nil)
            initVC = storyboard?.instantiateViewController(withIdentifier: "PositionViewPortraitController") as! PositionViewPortraitController
        }
        self.window?.rootViewController = initVC
        self.window?.makeKeyAndVisible()
    }
//    @objc func launch(){
//        if UIDevice.current.orientation.isLandscape {
//            launchScreen = UIStoryboard.init(name: "LaunchScreenLandscape", bundle: nil)
//            initlaunch = launchScreen?.instantiateViewController(withIdentifier: "LaunchLandscape")
//        }
//
//        if UIDevice.current.orientation.isPortrait {
//            storyboard = UIStoryboard.init(name: "MainPortrait", bundle: nil)
//            initlaunch = storyboard?.instantiateViewController(withIdentifier: "PositionViewPortraitController") as! PositionViewPortraitController
//        }
//        self.window?.rootViewController = initlaunch
//        self.window?.makeKeyAndVisible()
//    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
//        NotificationCenter.default.addObserver(self, selector: #selector(launch), name: UIDevice.orientationDidChangeNotification, object: nil)
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
         NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: UIDevice.orientationDidChangeNotification, object: nil)
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: UIDevice.orientationDidChangeNotification, object: nil)
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: UIDevice.orientationDidChangeNotification, object: nil)
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: UIDevice.orientationDidChangeNotification, object: nil)
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

