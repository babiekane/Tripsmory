//
//  RootViewModel.swift
//  Tripsmory
//
//  Created by yossa on 22/8/2566 BE.
//

import Foundation
import FirebaseAuth

final class RootViewModel: ObservableObject {
  
  init(factory: RootViewFactory) {
    self.factory = factory
  }
  
  let factory: RootViewFactory
  
  @Published var isLoggedIn = false
  
  private let auth = Auth.auth()
  
  func onAuthSuccess() {
    isLoggedIn = true
  }
  
  func onSignoutSuccess() {
    isLoggedIn = false
  }
  
  func onAppear() {
    fetchInitialState()
  }
  
  private func fetchInitialState() {
    isLoggedIn = auth.currentUser != nil
  }
}
