//
//  ManageAccountViewModel.swift
//  Tripsmory
//
//  Created by yossa on 24/8/2566 BE.
//

import Foundation
import FirebaseAuth

final class ManageAccountViewModel: ObservableObject {
  
  init(onDelete: @escaping () -> Void) {
    self.onDelete = onDelete
  }
  
  let onDelete: () -> Void
  
  @Published var errorMessage: String?
  
  func deleteUser() {
    let user = Auth.auth().currentUser

    user?.delete { [weak self] error in
      guard let self = self else { return }
      DispatchQueue.main.async {
        if let error = error?.localizedDescription {
          self.errorMessage = error
        } else {
          self.onDelete()
        }
      }
    }
  }
}
