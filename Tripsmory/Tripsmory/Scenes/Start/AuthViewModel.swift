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
  
  var isLoggedIn: Bool {
    return auth.currentUser != nil
  }
  
  func  logIn(email: String, password: String) {
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
  
  func  signUp(email: String, password: String) {
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
  
}
