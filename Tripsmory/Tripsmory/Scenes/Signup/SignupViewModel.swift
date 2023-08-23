//
//  SignupViewModel.swift
//  Tripsmory
//
//  Created by yossa on 22/8/2566 BE.
//

import Foundation
import SwiftUI
import CryptoKit
import GoogleSignIn
import GoogleSignInSwift
import AuthenticationServices
import FirebaseAuth

final class SignupViewModel: NSObject, ObservableObject {
  
  init(onSignupSuccess: @escaping () -> Void, onPressLogin: @escaping () -> Void) {
    self.onSignupSuccess = onSignupSuccess
    self.onPressLogin = onPressLogin
  }

  let onSignupSuccess: () -> Void
  let onPressLogin: () -> Void
  
  @Published var isLoading = false
  
  private var nonce = ""
  private let auth = Auth.auth()
  
  func proceedToLogin() {
    onPressLogin()
  }
  
  func signUp(email: String, password: String) {
    isLoading = true
    
    auth.createUser(withEmail: email, password: password) { [weak self] result, error in
      DispatchQueue.main.async {
        self?.isLoading = false
        
        guard result != nil, error == nil else {
          return
        }
        
        self?.onSignupSuccess()
      }
    }
  }
  
  func logInWithApple() {
    let appleIDProvider = ASAuthorizationAppleIDProvider()
    let request = appleIDProvider.createRequest()
    let nonce = randomNonceString()
    self.nonce = nonce
    request.requestedScopes = [.email, .fullName]
    request.nonce = sha256(nonce)
        
    let authorizationController = ASAuthorizationController(authorizationRequests: [request])
    authorizationController.delegate = self
    authorizationController.presentationContextProvider = UIApplication.shared.windows.first?.rootViewController
    authorizationController.performRequests()
  }
  
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
          self.onSignupSuccess()
        }
      }
    }
  }
}

extension SignupViewModel: ASAuthorizationControllerDelegate {
  func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
    print(error.localizedDescription)
  }
  
  func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
    guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else {
      print("error with firebase")
      return
    }
    
    // Getting Token
    guard let token = credential.identityToken else {
      print("error with firebase")
      return
    }
    
    // Token string
    guard let tokenString = String(data: token, encoding: .utf8) else {
      print("error with Token")
      return
    }
    
    let firebaseCredential = OAuthProvider.credential(withProviderID: "apple.com", idToken: tokenString, rawNonce: nonce)
    
    Auth.auth().signIn(with: firebaseCredential) { result, error in
      if let error = error {
        print(error.localizedDescription)
        return
      }
      
      //success
      DispatchQueue.main.async {
        self.onSignupSuccess()
      }
    }
  }
}
