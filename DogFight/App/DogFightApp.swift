//
//  DogFightApp.swift
//  DogFight
//
//  Created by 임대진 on 2023/09/15.
//

import SwiftUI
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}

@main
struct DogFightApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var initialViewStore = InitialViewStore()
    @StateObject private var tabStore = TabStore()
    @StateObject private var myProfileStore: MyProfileStore = MyProfileStore()
    
    var body: some Scene {
        WindowGroup {
            if initialViewStore.userSession != nil {
                    MainTabBarView()
                        .environmentObject(tabStore)
                        .environmentObject(myProfileStore)
            } else {
                    SignInView()
            }
        }
    }
}
