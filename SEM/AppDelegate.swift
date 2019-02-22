//
//  AppDelegate.swift
//  SEM
//
//  Created by Ipman on 12/20/18.
//  Copyright © 2018 Ipman. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import EMAlertController
import FBSDKLoginKit
import FBSDKCoreKit
import GoogleSignIn
import Firebase
import UserNotifications
import GoogleMaps
import GooglePlaces
enum ErrorTokenType: String {
    case ERR_TOKEN = "ERR_TOKEN"
    case ERR_TOKEN_EXP = "ERR_TOKEN_EXP"
    case ERR_TOKEN_FAILED = "ERR_TOKEN_FAILED"
    case ERR_TOKEN_REF_EXP = "ERR_TOKEN_REF_EXP"
    case ERR_TOKEN_REF_NOT = "ERR_TOKEN_REF_NOT"
}


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        Language.setLanguage("vi")
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        GMSServices.provideAPIKey(APIConstants.Google.apiKey!)
        GMSPlacesClient.provideAPIKey(APIConstants.Google.apiKey!)
        
        
        //checklogin
//        if  AuthenticationManager.sharedInstance.isLoggedIn {
            let viewController = UIStoryboard.storyboard(name: .Main).viewController(aClass: LoadingViewController.self)
            let viewControllers = [viewController]
            let navVC = UINavigationController()
            navVC.isNavigationBarHidden = true
            navVC.setViewControllers(viewControllers, animated: true)
            self.window?.rootViewController = navVC
//        }
        
        if launchOptions?[UIApplicationLaunchOptionsKey.remoteNotification] != nil {
            // Do what you want to happen when a remote notification is tapped.
        }
        
        
        AnalyticsConfiguration.shared().setAnalyticsCollectionEnabled(false)
        // register notifications
        registerFirebaseRemoteNotification(application: application)
        if launchOptions?[UIApplicationLaunchOptionsKey.remoteNotification] != nil {
            // Do what you want to happen when a remote notification is tapped.
        }
        // setting fb
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        // Config Google Sign-In
        GIDSignIn.sharedInstance().clientID = APIConstants.Google.clientId
        
        NotificationCenter.default.addObserver(self, selector: #selector(setToSignIn), name: NSNotification.Name(rawValue: "notiRootSignIn"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloginAccount), name: NSNotification.Name(rawValue: "notiReloginAccount"), object: nil)
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        Messaging.messaging().shouldEstablishDirectChannel = true
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        connectToFcm()
        FBSDKAppEvents.activateApp()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        InstanceID.instanceID().instanceID { (result, error) in
            if let error = error {
                print("Error fetching remote instange ID: \(error)")
            } else if let result = result {
                print("Remote instance ID token: \(result.token)")
                //AuthenticationManager.sharedInstance.firebasePushToken = result.token
            }
        }
        print("APNs token retrieved: \(deviceToken)")
        
        // With swizzling disabled you must set the APNs token here.
        Messaging.messaging().apnsToken = deviceToken
    }
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Unable to register for remote notifications: \(error.localizedDescription)")
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        Messaging.messaging().appDidReceiveMessage(userInfo)
        completionHandler(UIBackgroundFetchResult.newData)
    }
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        if url.absoluteString.contains(APIConstants.Facebook.appId){
            return FBSDKApplicationDelegate.sharedInstance().application(app,
                                                                         open: url,
                                                                         options: options)
        }
        let sourceApplication = options[.sourceApplication] as! String
        return GIDSignIn.sharedInstance().handle(url,
                                                 sourceApplication: sourceApplication,
                                                 annotation: options[.annotation])
    }


}
extension AppDelegate{
    
    func logout(){
        if !AuthenticationManager.sharedInstance.cachedCustomer.fbId.isEmpty {
            FBSDKLoginManager().logOut()
        }
        if !AuthenticationManager.sharedInstance.cachedCustomer.ggId.isEmpty{
            GIDSignIn.sharedInstance().signOut()
        }
        AuthenticationManager.sharedInstance.isLoggedIn = false // flag logout
        AuthenticationManager.sharedInstance.removeCachedToken() // xoá token
        AuthenticationManager.sharedInstance.removeCachedCustomer() // xoá thông tin khách hàng
        AuthenticationManager.sharedInstance.removeCartDevice() // xóa thông tin giỏ hàng
    }
    @objc func setToSignIn(notification: NSNotification){
        self.logout()
        let viewController = UIStoryboard.storyboard(name: .Login).viewController(aClass: SignInViewController.self)
        let viewControllers = [viewController]
        let navVC = UINavigationController()
        navVC.isNavigationBarHidden = true
        navVC.setViewControllers(viewControllers, animated: true)
        self.window?.rootViewController = navVC
    }
    
    @objc func reloginAccount(notification: NSNotification){
        let alert = EMAlertController(title: "SEM", message: "Quá hạn thời gian thực thi.Vui lòng đăng nhập lại!")
        let confirm = EMAlertAction(title: "OK", style: .normal) {
            self.logout()
            let viewController = UIStoryboard.storyboard(name: .Login).viewController(aClass: SignInViewController.self)
            let viewControllers = [viewController]
            let navVC = UINavigationController()
            navVC.isNavigationBarHidden = true
            navVC.setViewControllers(viewControllers, animated: true)
            self.window?.rootViewController = navVC
        }
        alert.addAction(confirm)

        // Present dialog
        let navVC = window!.rootViewController as! UINavigationController
        let vc = navVC.topViewController!
        vc.present(alert, animated: true, completion: nil)
    }
    
    func connectToFcm() {
        // Won't connect since there is no token
        InstanceID.instanceID().instanceID { (result, error) in
            if let result = result {
                print("Remote instance ID token: \(result.token)")
            }else{
                return
            }
        }
        // Disconnect previous FCM connection if it exists.
        Messaging.messaging().shouldEstablishDirectChannel = true
    }
    @objc func tokenRefreshNotification(_ notification: Notification) {
        InstanceID.instanceID().instanceID { (result, error) in
            if let error = error {
                print("Error fetching remote instange ID: \(error)")
            } else if let result = result {
                print("Remote instance ID token: \(result.token)")
                //AuthenticationManager.sharedInstance.firebasePushToken = result.token
            }
        }
        // Connect to FCM since connection may have failed when attempted before having a token.
        connectToFcm()
    }
    @objc func fcmConnectionStateChange() {
        if Messaging.messaging().isDirectChannelEstablished {
            print("Connected to FCM.")
        } else {
            print("Disconnected from FCM.")
        }
    }
    func registerFirebaseRemoteNotification(application: UIApplication){
        UIApplication.shared.applicationIconBadgeNumber = 0
        FirebaseApp.configure() // cấu hình firebase
        Messaging.messaging().delegate = self
        if #available(iOS 10.0, *) {
            
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {(granted, error) in
                    print("Permission granted: \(granted)")
                    
                    guard granted else { return }
            })
            
            
        }else{
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
            
        }
        application.registerForRemoteNotifications()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.tokenRefreshNotification),
                                               name: .InstanceIDTokenRefresh,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector:#selector(self.fcmConnectionStateChange),
                                               name: .MessagingConnectionStateChanged,
                                               object: nil)
    }
}
extension AppDelegate: UNUserNotificationCenterDelegate{
    // Receive displayed notifications for iOS 10 devices.
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        let userInfo = notification.request.content.userInfo
        print(userInfo)
        
        completionHandler([.alert, .badge, .sound]);
    }
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        print(userInfo)
        UIApplication.shared.applicationIconBadgeNumber -= 1
        
        completionHandler()
        
    }
}
extension AppDelegate : MessagingDelegate {
    // Receive data message on iOS 10 devices while app is in the foreground.
    func application(received remoteMessage: MessagingRemoteMessage) {
        print(remoteMessage.appData)
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
        let dataDict:[String: String] = ["token": fcmToken]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
    }
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print("\(remoteMessage.messageID)")
    }
}
