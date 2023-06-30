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
import AuthenticationServices

class AuthViewModel: NSObject, ObservableObject {
  
  @Published var loggedIn = false
  @Published var loading = false
  
  @Published var errorMessage: String?
  
  @Published var startState = StartState.start
  @Published var animationState = StartState.start
  
  @Published var nonce = ""
  
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
  
  /// Login with facebook
//  func logInWithFacebook() {
//    let configuration = LoginConfiguration(permissions: ["public_profile", "email"], tracking: .enabled)
//    loginManager.logIn(configuration: configuration) { loginResult in
//      switch loginResult {
//      case .success(_, _, let token):
//        guard let accessToken = token?.tokenString else {
//          return
//        }
//
//        let credential = OAuthProvider.credential(withProviderID: "facebook.com", accessToken: accessToken)
//        self.auth.signIn(with: credential) { authResult, error in
//          if let error = error {
//            print(error.localizedDescription)
//            return
//          }
//
//          DispatchQueue.main.async {
//            self.loggedIn = true
//          }
//        }
//
//      case .failed(let error):
//        print(error.localizedDescription)
//
//      case .cancelled:
//        break
//      }
//    }
//  }
  
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
  
  // Login with twitter
  func logInWithTwitter() {
    var provider = OAuthProvider(providerID: "twitter.com")
    
    provider.getCredentialWith(nil) { credential, error in
      if error != nil {
        // Handle error.
      }
      
      if let credential = credential {
        Auth.auth().signIn(with: credential) { authResult, error in
          if error != nil {
            // Handle error.
          }
          // User is signed in.
          // IdP data available in authResult.additionalUserInfo.profile.
          // Twitter OAuth access token can also be retrieved by:
          // (authResult.credential as? OAuthCredential)?.accessToken
          // Twitter OAuth ID token can be retrieved by calling:
          // (authResult.credential as? OAuthCredential)?.idToken
          // Twitter OAuth secret can be retrieved by calling:
          // (authResult.credential as? OAuthCredential)?.secret
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

extension AuthViewModel: ASAuthorizationControllerDelegate {
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
        self.loggedIn = true
      }
    }
  }
}
  
// Login with Apple

func sha256(_ input: String) -> String {
  let inputData = Data(input.utf8)
  let hashedData = SHA256.hash(data: inputData)
  let hashString = hashedData.compactMap {
    String(format: "%02x", $0)
  }.joined()
  
  return hashString
}

func randomNonceString(length: Int = 32) -> String {
  precondition(length > 0)
  var randomBytes = [UInt8](repeating: 0, count: length)
  let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
  if errorCode != errSecSuccess {
    fatalError(
      "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
    )
  }
  
  let charset: [Character] =
  Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
  
  let nonce = randomBytes.map { byte in
    // Pick a random character from the set, wrapping around if needed.
    charset[Int(byte) % charset.count]
  }
  
  return String(nonce)
}

extension UIViewController: ASAuthorizationControllerPresentationContextProviding {
  public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
    return view.window!
  }
}
