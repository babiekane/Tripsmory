//
//  StartCoordinatorViewFactory.swift
//  Tripsmory
//
//  Created by yossa on 21/8/2566 BE.
//

import SwiftUI

protocol StartCoordinatorViewFactory {
  func makeStartRoot(completion: @escaping () -> Void) -> AnyView
  func makeStartSignup(onSignupSuccess: @escaping () -> Void, onPressLogin: @escaping () -> Void) -> AnyView
  func makeStartLogin(onLoginSuccess: @escaping () -> Void, onPressSignup: @escaping () -> Void) -> AnyView
}
