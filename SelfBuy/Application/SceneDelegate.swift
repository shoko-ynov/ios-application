//
//  SceneDelegate.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 06/11/2019.
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.windowScene = windowScene
        
        let tabBarVC = TabBarViewController()
  
                
        window?.rootViewController = tabBarVC
        //window?.makeKeyAndVisible()
    }

    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        guard let url = userActivity.webpageURL else { return }
        
        if url.path == "/users/activation" {
            guard let key = url.valueOf("k"), let userId = url.valueOf("u") else {
                return
            }
            
            let activationVC = UserActivationViewController(viewModel: UserActivationViewModel(
                key: key,
                userId: userId)
            )
            
            window?.rootViewController = TabBarService.shared.tabBarController
            window?.rootViewController?.present(activationVC, animated: true)
            window?.makeKeyAndVisible()
        }
        
        if url.path == "/payment/stripe/return" {
            guard let paymentIntentId = url.valueOf("payment_intent"), let clientSecret = url.valueOf("payment_intent_client_secret") else { return }
            
            let service = PaymentApiService()
            
            window?.rootViewController = TabBarService.shared.tabBarController
            window?.makeKeyAndVisible()
            
            service.getStripePayementIntent(StripePaymentParams(paymentIntentId: paymentIntentId, clientSecret: clientSecret)) {
                switch $0 {
                case .success(let paymentIntent):
                    switch paymentIntent.status {
                    case .succeeded:
                        //let payementSucceededVC =
                        //window?.rootViewController?.present(payementSucceededVC, animated: true)
                        print("success")
                    case .requires_payment_method, .requires_action:
                        //let payementErrorVC =
                        //window?.rootViewController?.present(payementErrorVC, animated: true)
                        print("fail")
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
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

