//
//  StartCoordinatorViewModel.swift
//  Tripsmory
//
//  Created by yossa on 22/8/2566 BE.
//

import Foundation

final class StartCoordinatorViewModel: ObservableObject {
  
  init(factory: StartCoordinatorViewFactory, onAuthSuccess: @escaping () -> Void) {
    self.factory = factory
    self.onAuthSuccess = onAuthSuccess
  }
  
  let factory: StartCoordinatorViewFactory
  let onAuthSuccess: () -> Void
  
  @Published var state: StartState = .start
  
  func onLoginSuccess() {
    onAuthSuccess()
  }
  
  func onSignupSuccess() {
    onAuthSuccess()
  }
  
  func onStartCompleted() {
    state = .signup
  }
  
  func onLoginPressed() {
    state = .login
  }
  
  func onSignupPressed() {
    state = .signup
  }
}

enum StartState {
  case start, signup, login
}
