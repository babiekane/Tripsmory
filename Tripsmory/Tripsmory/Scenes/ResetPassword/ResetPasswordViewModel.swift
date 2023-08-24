//
//  ResetPasswordViewModel.swift
//  Tripsmory
//
//  Created by yossa on 24/8/2566 BE.
//

import Foundation
import FirebaseAuth

final class ResetPasswordViewModel: ObservableObject {
  
  init(onResetPasswordSuccess: @escaping () -> Void) {
    self.onResetPasswordSuccess = onResetPasswordSuccess
  }
  
  let onResetPasswordSuccess: () -> Void
  
  func forgotPassword(email: String) {
    Auth.auth().sendPasswordReset(withEmail: email) { [weak self] error in
      if let error = error {
        print(error.localizedDescription)
        return
      }
      
      self?.onResetPasswordSuccess()
    }
  }
}
