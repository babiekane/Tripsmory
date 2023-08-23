//
//  SettingsViewModel.swift
//  Tripsmory
//
//  Created by yossa on 22/8/2566 BE.
//

import Foundation
import FirebaseAuth

final class SettingsViewModel: ObservableObject {
  
  init(onSignoutSuccess: @escaping () -> Void) {
    self.onSignoutSuccess = onSignoutSuccess
  }
  
  let onSignoutSuccess: () -> Void
  
  private let auth = Auth.auth()
  
  func signOut() {
    do {
      try auth.signOut()
      onSignoutSuccess()
    } catch {
      print(error.localizedDescription)
    }
  }
}
