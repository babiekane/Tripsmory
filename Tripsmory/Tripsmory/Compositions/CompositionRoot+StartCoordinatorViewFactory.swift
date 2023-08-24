//
//  CompositionRoot+StartCoordinatorViewFactory.swift
//  Tripsmory
//
//  Created by yossa on 21/8/2566 BE.
//

import SwiftUI

extension CompositionRoot: StartCoordinatorViewFactory {
  func makeStartRoot(completion: @escaping () -> Void) -> AnyView {
    let viewModel = StartViewModel(completion: completion)
    let view = StartView(viewModel: viewModel)
    return AnyView(view)
  }
  
  func makeStartSignup(onSignupSuccess: @escaping () -> Void, onPressLogin: @escaping () -> Void) -> AnyView {
    let viewModel = SignupViewModel(onSignupSuccess: onSignupSuccess, onPressLogin: onPressLogin)
    let view = SignupView(viewModel: viewModel)
    return AnyView(view)
  }
  
  func makeStartLogin(onLoginSuccess: @escaping () -> Void, onPressSignup: @escaping () -> Void) -> AnyView {
    let viewModel = LoginViewModel(onLoginSuccess: onLoginSuccess, onPressSignup: onPressSignup)
    let view = LoginView(viewModel: viewModel)
    return AnyView(view)
  }
}
