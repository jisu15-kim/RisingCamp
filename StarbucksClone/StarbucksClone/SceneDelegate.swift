//
//  SceneDelegate.swift
//  StarbucksClone
//
//  Created by 김지수 on 2022/11/28.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var tempImage: UIImageView?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        print(#function)
        
        self.window = UIWindow(windowScene: scene as! UIWindowScene)
        let story = UIStoryboard(name: "Main", bundle: nil)
        
        if UserDefaults.standard.bool(forKey: "isOnBoarding") == false {
            // 키가 존재하지 않으면 false = 첫 실행
            print("첫 실행이야")
            guard let vc = story.instantiateViewController(withIdentifier: "OnBordingViewController") as? OnBordingViewController else { return }
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            UserDefaults.standard.set(true, forKey: "isOnBoarding")
            
            // 일단 테스트는 해야하니 .. 다시 제거
            UserDefaults.standard.removeObject(forKey: "isOnBoarding")
        } else {
            // 키가 존재하면 true = 첫 실행 아님
            print("첫 실행 아니야")
            guard let vc = story.instantiateViewController(withIdentifier: "homeTabBar") as? UITabBarController else { return }
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            
            // 테스트용
            UserDefaults.standard.removeObject(forKey: "isOnBoarding")
        }
        guard let _ = (scene as? UIWindowScene) else { return }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        guard let image = tempImage else { return }
        image.removeFromSuperview()
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        guard let window = window else { return }
        tempImage = UIImageView(frame: window.frame)
        tempImage?.image = UIImage(named: "tempImage")
        window.addSubview(tempImage!)
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        print("백그라운드로 갑니다")
        
    }
}

