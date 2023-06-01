//
//  TripsmoryApp.swift
//  Tripsmory
//
//  Created by CatMeox on 28/3/2566 BE.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
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
          
        }
    }
}
