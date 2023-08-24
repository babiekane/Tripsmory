//
//  SettingsViewModel.swift
//  Tripsmory
//
//  Created by yossa on 22/8/2566 BE.
//

import Foundation
import FirebaseAuth

final class SettingsViewModel: ObservableObject {
  
  init(onResetPasswordSelected: @escaping () -> Void, onManageAccountSelected: @escaping () -> Void, onPrivacyPolicySelected: @escaping () -> Void, onSupportAndFeedbackSelected: @escaping () -> Void, onSignoutSuccess: @escaping () -> Void) {
    self.onResetPasswordSelected = onResetPasswordSelected
    self.onManageAccountSelected = onManageAccountSelected
    self.onPrivacyPolicySelected = onPrivacyPolicySelected
    self.onSupportAndFeedbackSelected = onSupportAndFeedbackSelected
    self.onSignoutSuccess = onSignoutSuccess
  }
  
  let onResetPasswordSelected: () -> Void
  let onManageAccountSelected: () -> Void
  let onPrivacyPolicySelected: () -> Void
  let onSupportAndFeedbackSelected: () -> Void
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
  
  func selectResetPassword() {
    onResetPasswordSelected()
  }
  
  func selectManageAccount() {
    onManageAccountSelected()
  }
  
  func selectPrivacyPolicy() {
    onPrivacyPolicySelected()
  }
  
  func selectSupportAndFeedback() {
    onSupportAndFeedbackSelected()
  }
}
