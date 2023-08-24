//
//  LoginViewModel.swift
//  Tripsmory
//
//  Created by yossa on 22/8/2566 BE.
//

import Foundation
import FirebaseAuth

final class LoginViewModel: ObservableObject {
  
  init(onLoginSuccess: @escaping () -> Void, onPressSignup: @escaping () -> Void) {
    self.onLoginSuccess = onLoginSuccess
    self.onPressSignup = onPressSignup
  }
  
  let onLoginSuccess: () -> Void
  let onPressSignup: () -> Void
  
  @Published var isLoading = false
  @Published var errorMessage: String?
  
  private let auth = Auth.auth()
  
  func logIn(email: String, password: String) {
    if email.isEmpty || password.isEmpty {
      errorMessage = "Please fill email and password."
    } else {
      isLoading = true
      
      auth.signIn(withEmail: email, password: password) { [weak self] result, error in
        DispatchQueue.main.async {
          self?.isLoading = false
          
          if let error = error?.localizedDescription {
            self?.errorMessage = error
          } else {
            guard result != nil else {
              return
            }
            
            self?.onLoginSuccess()
          }
        }
      }
    }
  }
  
  func proceedToSignup() {
    onPressSignup()
  }
}
