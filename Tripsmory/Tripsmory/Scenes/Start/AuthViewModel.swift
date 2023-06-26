//
//  LogInViewModel.swift
//  Tripsmory
//
//  Created by CatMeox on 25/5/2566 BE.
//

import SwiftUI
import FirebaseAuth
import FacebookLogin
import CryptoKit
import GoogleSignIn
import GoogleSignInSwift

class AuthViewModel: ObservableObject {
  
  @Published var loggedIn = false
  @Published var loading = false
  
  @Published var errorMessage: String?
  
  @Published var startState = StartState.start
  @Published var animationState = StartState.start
  
  let auth = Auth.auth()
  let loginManager = LoginManager()
  
  func start() {
    
    if auth.currentUser == nil {
      loggedIn = false
    } else {
      loggedIn = true
    }
  }
  
  // Login with email & password
  func logIn(email: String, password: String) {
    if email.isEmpty || password.isEmpty {
      errorMessage = "Please fill email and password."
    } else {
      
      loading = true
      
      auth.signIn(withEmail: email, password: password) { [weak self] result, error in
        DispatchQueue.main.async {
          self?.loading = false
        }
        
        if let error = error?.localizedDescription {
          self?.errorMessage = error
        } else {
          guard result != nil else {
            return
          }
          
          DispatchQueue.main.async {
            // success
            self?.loggedIn = true
          }
        }
      }
    }
  }
  
  // Sign up with email & password
  func signUp(email: String, password: String) {
    loading = true
    
    auth.createUser(withEmail: email, password: password) { [weak self] result, error in
      guard result != nil, error == nil else {
        self?.loading = false
        return
      }
      
      DispatchQueue.main.async {
        // success
        self?.loading = false
        self?.loggedIn = true
      }
    }
  }
  
  // Sign out
  func signOut() {
    try? auth.signOut()
    
    self.loggedIn = false
  }
  
  // Login with Apple
  func logInWithApple() {
    //TODO
  }
  
  // Login with facebook
  func logInWithFacebook() {
    let configuration = LoginConfiguration(permissions: ["public_profile", "email"], tracking: .enabled)
    loginManager.logIn(configuration: configuration) { loginResult in
      switch loginResult {
      case .success(_, _, let token):
        guard let accessToken = token?.tokenString else {
          return
        }
        
        let credential = OAuthProvider.credential(withProviderID: "facebook.com", accessToken: accessToken)
        self.auth.signIn(with: credential) { authResult, error in
          if let error = error {
            print(error.localizedDescription)
            return
          }
          
          DispatchQueue.main.async {
            self.loggedIn = true
          }
        }
        
      case .failed(let error):
        print(error.localizedDescription)
        
      case .cancelled:
        break
      }
    }
  }
  
  // Login with Gmail
  func logInWithGoogle() {
    guard let rootViewController = UIApplication.shared.windows.first?.rootViewController else {
      return
    }
    
    GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { signInResult, error in
      guard let result = signInResult else {
        // Inspect error
        if let error = error {
          print(error.localizedDescription)
          return
        }
        return
      }
      
      let user = result.user
      guard let idToken = user.idToken?.tokenString else {
        return
      }
      let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                     accessToken: user.accessToken.tokenString)
      self.auth.signIn(with: credential) { authResult, error in
        if let error = error {
          print(error.localizedDescription)
          return
        }
        
        DispatchQueue.main.async {
          self.loggedIn = true
        }
      }
    }
  }
  
  // Forgot password from login with email & password
  func forgotPassword(email: String) {
    Auth.auth().sendPasswordReset(withEmail: email) { error in
    }
  }
  
  func deleteUser() {
    let user = Auth.auth().currentUser

    user?.delete { error in
      DispatchQueue.main.async {
        if let error = error?.localizedDescription {
          self.errorMessage = error
        } else {
          self.loggedIn = false
          
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.startState = .start
          }
        }
      }
    }
  }
}
