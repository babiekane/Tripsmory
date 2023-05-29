//
//  LogInViewModel.swift
//  Tripsmory
//
//  Created by CatMeox on 25/5/2566 BE.
//

import SwiftUI
import FirebaseAuth


class AuthViewModel: ObservableObject {
  
  @Published var loggedIn = false
    
  let auth = Auth.auth()
  
  func start() {
//    loggedIn = auth.currentUser != nil
    
    if auth.currentUser == nil {
      loggedIn = false
    } else {
      loggedIn = true
    }
  }
  
  func logIn(email: String, password: String) {
    auth.signIn(withEmail: email, password: password) { [weak self] result, error in
      guard result != nil, error == nil else {
        return
      }
      
      DispatchQueue.main.async {
        // success
        self?.loggedIn = true
      }
      
    }
  }
  
  func signUp(email: String, password: String) {
    auth.createUser(withEmail: email, password: password) { [weak self] result, error in
      guard result != nil, error == nil else {
        return
      }
      
      DispatchQueue.main.async {
        // success
        self?.loggedIn = true
      }
    }
  }
  
  func signOut() {
    try? auth.signOut()
    
    self.loggedIn = false
  }
  
}
