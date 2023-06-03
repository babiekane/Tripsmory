//
//  TripsmoryApp.swift
//  Tripsmory
//
//  Created by CatMeox on 28/3/2566 BE.
//

import SwiftUI
import FirebaseCore
import UIKit
import FacebookCore
import GoogleSignIn

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    
    ApplicationDelegate.shared.application(
      application,
      didFinishLaunchingWithOptions: launchOptions
    )
    
    FirebaseApp.configure()
    
    return true
  }
  
  func application(
    _ app: UIApplication,
    open url: URL,
    options: [UIApplication.OpenURLOptionsKey : Any] = [:]
  ) -> Bool {
    ApplicationDelegate.shared.application(
      app,
      open: url,
      sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
      annotation: options[UIApplication.OpenURLOptionsKey.annotation]
    )
  }
}


@main
struct TripsmoryApp: App {
  
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
  //  @StateObject var tripListViewModel: TripListViewModel = TripListViewModel()
  @StateObject var authViewModel: AuthViewModel = AuthViewModel()
  
  var body: some Scene {
    WindowGroup {
      RootView()
        .environmentObject(authViewModel)
        .onOpenURL { url in
          GIDSignIn.sharedInstance.handle(url)
        }
    }
  }
}
