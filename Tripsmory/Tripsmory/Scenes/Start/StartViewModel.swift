//
//  StartViewModel.swift
//  Tripsmory
//
//  Created by yossa on 22/8/2566 BE.
//

import Foundation

final class StartViewModel: ObservableObject {

  // MARK: Lifecycle

  init(completion: @escaping () -> Void) {
    self.completion = completion
  }

  // MARK: Internal

  let completion: () -> Void

  func proceed() {
    completion()
  }
}
